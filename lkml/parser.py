"""Parses a sequence of tokenized LookML into a Python object."""

import logging
from typing import Optional, Sequence, Type, Union, Tuple, List
from functools import wraps
import lkml.tokens as tokens
import lkml.tree as tree

# Delimiter character used during logging to show the depth of nesting
DELIMITER = ". "
Syntax = Union[tree.SyntaxNode, tree.SyntaxToken]


def backtrack_if_none(fn):
    """Decorates parsing methods to backtrack to a previous position on failure.

    This method sets a marker at the current position before attempting to run a
    parsing method. If the parsing method fails and returns `None`, it resets the
    index to the marker.

    It also keeps track of the farthest index of progress in case all parsing
    methods fail and we need to return a SyntaxError to the user with a character
    number.

    Args:
        method (Callable): Method to be decorated for backtracking

    """

    @wraps(fn)
    def wrapper(self, *args, **kwargs):
        mark = self.index
        self.depth += 1
        result = fn(self, *args, **kwargs)
        self.depth -= 1
        if result is None:
            self.progress = self.index if self.index > self.progress else self.progress
            self.jump_to_index(mark)
        return result

    return wrapper


class Parser:
    r"""Parses a sequence of tokenized LookML into a Python object.

    This parser is a recursive descent parser which uses the grammar listed below (in
    PEG format). Each grammar rule aligns with a corresponding method (e.g.
    parse_expression).

    Attributes:
        tokens: A sequence of tokens
        index: The position in the token sequence being evaluated
        progress: The farthest point of progress during parsing
        logger: Own logging Logger instance
        depth: The level of recursion into nested expressions
        log_debug: A flag indicating that debug messages should be logged. This flag
            exits to turn off logging flow entirely, which provides a small
            performance gain compared to parsing at a non-debug logging level.

    Grammar:
        expression ← (block / pair / list)*
        block ← key literal? "{" expression "}"
        pair ← key value
        list ← key "[" csv? "]"
        csv ← (literal / quoted_literal) ("," (literal / quoted_literal))* ","?
        value ← literal / quoted_literal / expression_block
        key ← literal ":"
        expression_block ← [^;]* ";;"
        quoted_literal ← '"' [^\"]+ '"'
        literal ← [0-9A-Za-z_]+

    """

    def __init__(self, stream: Sequence[tokens.Token]):
        """Initializes the Parser with a stream of tokens and sets the index.

        Args:
            stream: Lexed sequence of tokens to be parsed

        Raises:
            TypeError: If an object in the stream is not a valid token

        """
        for token in stream:
            if not isinstance(token, tokens.Token):
                raise TypeError(
                    f"Type {type(token)} for {token} is not a valid token type."
                )
        self.tokens = stream
        self.index: int = 0
        self.progress: int = 0
        self.logger: logging.Logger = logging.getLogger(__name__)
        self.depth: int = -1
        self.log_debug: bool = self.logger.isEnabledFor(logging.DEBUG)

    def jump_to_index(self, index: int):
        """Sets the parser index to a specified value."""
        self.index = index

    def peek(self) -> tokens.Token:
        """Returns the token at the current index."""
        return self.tokens[self.index]

    def advance(self, length: int = 1):
        """Moves the index forward by n characters.

        Args:
            length: The number of positions forward to move the index.

        """
        self.index += length

    def consume(self) -> tokens.Token:
        """Returns the current index character and advances the index by 1 token."""
        self.advance()
        return self.tokens[self.index - 1]

    def consume_token_value(self) -> str:
        """Returns the value of the current index token, advancing the index 1 token."""
        token = self.consume()
        if token.value is None:
            raise ValueError("Token %s does not have a consumable value." % token)
        return token.value

    def consume_trivia(self) -> str:
        """Returns all continuous trivia values."""
        trivia = ""
        while True:
            if self.check(tokens.CommentToken, tokens.WhitespaceToken):
                trivia += self.consume_token_value()
            else:
                break
        return trivia

    def check(
        self, *token_types: Type[tokens.Token], skip_trivia: bool = False
    ) -> bool:
        """Compares the current index token type to specified token types.

        Args:
            *token_types: A variable number of token types to check against

        Raises:
            TypeError: If one or more of the token_types are not actual token types

        Returns:
            bool: True if the current token matches one of the token_types

        """
        if self.log_debug:
            self.logger.debug(
                "%sCheck %s == %s",
                (1 + self.depth) * DELIMITER,
                self.peek(),
                " or ".join(t.__name__ for t in token_types),
            )
        for token_type in token_types:
            if not issubclass(token_type, tokens.Token):
                raise TypeError(f"{token_type} is not a valid token type.")

        # Set a bookmark to skip over trivia tokens before the check if asked
        mark = self.index
        if skip_trivia:
            _ = self.consume_trivia()
        try:
            token = self.peek()
        except IndexError:
            # Reached the end of the stream
            result = False
        else:
            if type(token) in token_types:
                result = True
            else:
                result = False
        finally:
            if skip_trivia:
                self.jump_to_index(mark)
        return result

    def parse(self) -> dict:
        """Main method of this class and a wrapper for the expression parser."""
        return self.parse_container()

    @backtrack_if_none
    def parse_container(self) -> tree.ContainerNode:
        """Returns a parsed LookML dictionary from a sequence of tokens.

        Raises:
            SyntaxError: If unable to find a matching grammar rule for the stream

        Grammar:
            expression ← (block / pair / list)*

        """
        if self.log_debug:
            grammar = "[expression] = (block / pair / list)*"
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)
        items: List[Union[tree.BlockNode, tree.PairNode, tree.ListNode]] = []
        if self.check(tokens.StreamStartToken):
            self.advance()
        while not self.check(
            tokens.StreamEndToken, tokens.BlockEndToken, skip_trivia=True
        ):
            block = self.parse_block()
            if block is not None:
                items.append(block)
                continue

            pair = self.parse_pair()
            if pair is not None:
                items.append(pair)
                continue

            list_ = self.parse_list()
            if list_ is not None:
                items.append(list_)
                continue

            token = self.tokens[self.progress]
            raise SyntaxError(
                f"Unable to find a matching expression for '{token.id}' "
                f"on line {token.line_number}"
            )

        container = tree.ContainerNode(items=tuple(items))
        if self.log_debug:
            self.logger.debug(
                "%sSuccessfully parsed expression.", self.depth * DELIMITER
            )
        return container

    @backtrack_if_none
    def parse_block(self) -> Optional[tree.BlockNode]:
        """Returns a dictionary that represents a LookML block.

        Returns:
            A dictionary with the parsed block or None if the grammar doesn't match

        Grammar:
            block ← key literal? "{" expression "}"

        Examples:
            Input (before tokenizing into a stream):
            ------
            "dimension: dimension_name {
                label: "Dimension Label"
                sql: ${TABLE}.foo ;;
            }"

            Output (dictionary):
            -------
            {
                "name": "dimension_name",
                "label": "Dimension Label",
                "sql": "${TABLE}.foo"
            }

        """
        if self.log_debug:
            grammar = "[block] = key literal? '{' expression '}'"
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        key = self.parse_key()
        if key is None:
            return key

        if self.check(tokens.LiteralToken):
            name: Optional[tree.SyntaxToken] = tree.SyntaxToken(
                self.consume_token_value()
            )
        else:
            name = None

        prefix = self.consume_trivia()
        if self.check(tokens.BlockStartToken):
            self.advance()
            suffix = self.consume_trivia()
            left_brace = tree.LeftCurlyBrace(prefix=prefix, suffix=suffix)
        else:
            return None

        container = self.parse_container()

        prefix = self.consume_trivia()
        if self.check(tokens.BlockEndToken):
            self.advance()
            suffix = self.consume_trivia()
            right_brace = tree.RightCurlyBrace(prefix=prefix, suffix=suffix)

            block = tree.BlockNode(
                type=key[0],
                colon=key[1],
                name=name,
                left_brace=left_brace,
                container=container,
                right_brace=right_brace,
            )

            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed block.", self.depth * DELIMITER
                )
            return block
        else:
            return None

    @backtrack_if_none
    def parse_pair(self) -> Optional[tree.PairNode]:
        """Returns a dictionary that represents a LookML key/value pair.

        Returns:
            A dictionary with the parsed block or None if the grammar doesn't match

        Grammar:
            pair ← key value

        Examples:
            Input (before tokenizing into a stream):
            ------
            label: "Foo"

            Output (dictionary):
            -------
            {"label": "Foo"}

        """
        if self.log_debug:
            grammar = "[pair] = key value"
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        key = self.parse_key()
        value = self.parse_value()
        if key is None or value is None:
            return None

        pair = tree.PairNode(key=key[0], colon=key[1], value=value)
        self.logger.debug(self.depth * DELIMITER + "Successfully parsed pair.")
        return pair

    @backtrack_if_none
    def parse_key(self) -> Optional[Tuple[tree.SyntaxToken, tree.Colon]]:
        """Returns a string that represents a literal key.

        Returns:
            A dictionary with the parsed block or None if the grammar doesn't match

        Grammar:
            key ← literal ":"

        Examples:
            Input (before tokenizing into a stream)::
            ------
            label:

            Output (string):
            -------
            "label"

        """
        if self.log_debug:
            grammar = "[key] = literal ':'"
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)
        prefix = self.consume_trivia()
        if self.check(tokens.LiteralToken):
            key = tree.SyntaxToken(self.consume_token_value(), prefix=prefix)
        else:
            return None

        prefix = self.consume_trivia()
        if self.check(tokens.ValueToken):
            self.advance()
            suffix = self.consume_trivia()
            colon = tree.Colon(prefix=prefix, suffix=suffix)
        else:
            return None

        if self.log_debug:
            self.logger.debug("%sSuccessfully parsed key.", self.depth * DELIMITER)
        return key, colon

    @backtrack_if_none
    def parse_value(self) -> Optional[tree.SyntaxToken]:
        """Returns a string that represents a value.

        Returns:
            A string with the parsed value or None if the grammar doesn't match

        Grammar:
            value ← literal / quoted_literal / expression_block

        Examples:
            Input (before tokenizing into a stream):
            ------
            1) "Foo"
            2) "${TABLE}.foo ;;"

            Output (string):
            -------
            1) "Foo"
            2) "${TABLE}.foo"

        """
        if self.log_debug:
            grammar = "[value] = literal / quoted_literal / expression_block"
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        if self.check(tokens.LiteralToken):
            value = self.consume_token_value()
            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed value.", self.depth * DELIMITER
                )
            return tree.SyntaxToken(value)
        elif self.check(tokens.QuotedLiteralToken):
            value = self.consume_token_value()
            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed value.", self.depth * DELIMITER
                )
            return tree.QuotedSyntaxToken(value)
        elif self.check(tokens.ExpressionBlockToken):
            value = self.consume_token_value()
            if self.check(tokens.ExpressionBlockEndToken):
                self.advance()
            else:
                return None
            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed value.", self.depth * DELIMITER
                )
            return tree.ExpressionSyntaxToken(value)
        else:
            return None

    @backtrack_if_none
    def parse_list(self) -> Optional[tree.ListNode]:
        """Returns a dictionary that represents a LookML list.

        Returns:
            A dictionary with the parsed list or None if the grammar doesn't match

        Grammar:
            list ← key "[" csv? "]"

        Examples:
            Input (before tokenizing into a stream):
            ------
            "timeframes: [date, week]"

            Output (dictionary):
            -------
            {"timeframes": ["date", "week"]}

        """
        if self.log_debug:
            grammar = "[list] = key '[' csv? ']'"
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        key = self.parse_key()
        if key is None:
            return key

        prefix = self.consume_trivia()
        if self.check(tokens.ListStartToken):
            self.advance()
            left_bracket = tree.LeftBracket(prefix=prefix)
        else:
            return None

        csv = self.parse_csv()
        csv = csv or tuple()

        if self.check(tokens.ListEndToken):
            self.advance()
            suffix = self.consume_trivia()
            right_bracket = tree.RightBracket(suffix=suffix)
            node = tree.ListNode(
                type=key[0],
                colon=key[1],
                left_bracket=left_bracket,
                items=csv,
                right_bracket=right_bracket,
            )
            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed a list.", self.depth * DELIMITER
                )
            return node
        else:
            return None

    @backtrack_if_none
    def parse_csv(self) -> Optional[Tuple[tree.SyntaxToken]]:
        """Returns a tuple that represents comma-separated LookML values.

        Returns:
            A list with the parsed values or None if the grammar doesn't match

        Grammar:
            csv ← (literal / quoted_literal) ("," (literal / quoted_literal))* ","?

        Examples:
            Input (before tokenizing into a stream):
            ------
            1) "[date, week]"
            2) "['foo', 'bar']"

            Output (list):
            -------
            1) ["date", "week"]
            2) ["foo", "bar"]

        """
        if self.log_debug:
            grammar = '[csv] = (literal / quoted_literal) ("," (literal / quoted_literal))* ","?'
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        # Set a flag to ensure that all items are of the same type (pair or literal)
        pair_mode: bool = False
        values: Union[List[tree.SyntaxToken], List[tree.PairNode]] = []

        pair = self.parse_pair()
        if pair is not None:
            values.append(pair)
            pair_mode = True
        elif self.check(
            tokens.LiteralToken, tokens.QuotedLiteralToken, skip_trivia=True
        ):
            prefix = self.consume_trivia()
            value = self.parse_value()
            value.prefix = prefix
            value.suffix = self.consume_trivia()
            values.append(value)
        else:
            return None

        while not self.check(tokens.ListEndToken):
            if self.check(tokens.CommaToken):
                self.advance()
            else:
                return None

            if pair_mode:
                pair = self.parse_pair()
                if pair is None:
                    return None
                else:
                    values.append(pair)
            else:
                prefix = self.consume_trivia()
                if self.check(tokens.LiteralToken, tokens.QuotedLiteralToken):
                    value = self.parse_value()
                    value.prefix = prefix
                    value.suffix = self.consume_trivia()
                    values.append(value)
                elif self.check(tokens.ListEndToken):
                    break
                else:
                    return None

        if self.log_debug:
            self.logger.debug(
                "%sSuccessfully parsed comma-separated values.", self.depth * DELIMITER
            )
        return tuple(values)
