"""Parses a sequence of tokenized LookML into a parse tree."""

import logging
from dataclasses import dataclass, field
from functools import wraps
from typing import List, Optional, Sequence, Tuple, Type, Union

import lkml.tokens as tokens
import lkml.tree as tree
import lkml.utils as utils

# Delimiter character used during logging to show the depth of nesting
DELIMITER = ". "
Syntax = Union[tree.SyntaxNode, tree.SyntaxToken]

logger = logging.getLogger(__name__)


def backtrack_if_none(fn):
    """Decorates parsing methods to backtrack to a previous position on failure.

    This method sets a marker at the current position before attempting to run a
    parsing method. If the parsing method fails and returns `None`, it resets the
    index to the marker.

    It also keeps track of the farthest index of progress in case all parsing
    methods fail and we need to return a SyntaxError to the user with a character
    number.

    Args:
        fn (Callable): The method to be decorated for backtracking.

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


@dataclass
class CommaSeparatedValues:
    """Helper class to store a series of values and a flag for a trailing comma."""

    _values: list = field(default_factory=list)
    trailing_comma: Optional[tree.Comma] = None
    leading_comma: Optional[tree.Comma] = None

    def append(self, value):
        """Add a value to the private _values list."""
        self._values.append(value)

    @property
    def values(self) -> tuple:
        """Return the private _values list, cast to a tuple."""
        return tuple(self._values)


class Parser:
    r"""Parses a sequence of tokenized LookML into a parse tree.

    This parser is a recursive descent parser which uses the grammar listed below (in
    PEG format). Each grammar rule aligns with a corresponding method (e.g.
    parse_expression).

    Grammar:
        * ``expression`` ← ``(block / pair / list)*``
        * ``block`` ← ``key literal? "{" expression "}"``
        * ``pair`` ← ``key value``
        * ``list`` ← ``key "[" csv? "]"``
        * ``csv`` ← ``(literal / quoted_literal) ("," (literal / quoted_literal))* ","?``
        * ``value`` ← ``literal / quoted_literal / expression_block``
        * ``key`` ← ``literal ":"``
        * ``expression_block`` ← ``[^;]* ";;"``
        * ``quoted_literal`` ← ``'"' [^\"]+ '"'``
        * ``literal`` ← ``[0-9A-Za-z_]+``

    Attributes:
        tokens: A sequence of tokens to be parsed.
        index: The position in the token sequence being parsed.
        progress: The farthest index of progress during parsing.
        depth: The level of recursion into nested expressions.
        log_debug: A flag indicating that debug messages should be logged. This flag
            exits to turn off logging flow entirely, which provides a small
            performance gain compared to parsing at a non-debug logging level.

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
        self.depth: int = -1
        self.log_debug: bool = logger.isEnabledFor(logging.DEBUG)

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
            *token_types: A variable number of token types to check against.
            skip_trivia: Ignore trivia tokens when searching for a match.

        Raises:
            TypeError: If one or more of the token_types are not actual token types

        Returns:
            True if the current token matches one of the token_types.

        """
        # Set a bookmark to skip over trivia tokens before the check if asked
        mark = self.index
        if skip_trivia:
            _ = self.consume_trivia()

        if self.log_debug:
            logger.debug(
                "%sCheck %s == %s",
                (1 + self.depth) * DELIMITER,
                self.peek(),
                " or ".join(t.__name__ for t in token_types),
            )
        for token_type in token_types:
            if not issubclass(token_type, tokens.Token):
                raise TypeError(f"{token_type} is not a valid token type.")

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

    def parse(self) -> tree.DocumentNode:
        """Main method of this class and a wrapper for the container parser.

        Returns:
            A document node, the root node of the LookML parse tree.

        """
        if self.check(tokens.StreamStartToken):
            self.advance()
        prefix = self.consume_trivia()
        container = self.parse_container()
        suffix = self.consume_trivia()
        return tree.DocumentNode(container, prefix, suffix)

    @backtrack_if_none
    def parse_container(self) -> tree.ContainerNode:
        """Returns a container node that contains any number of children.

        Grammar: ``expression`` ← ``(block / pair / list)*``

        Returns:
            A node with the parsed container or None if the grammar doesn't match.

        Raises:
            SyntaxError: If unable to find a matching grammar rule for the stream

        """
        if self.log_debug:
            grammar = "[expression] = (block / pair / list)*"
            logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)
        items: List[Union[tree.BlockNode, tree.PairNode, tree.ListNode]] = []
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

        container = tree.ContainerNode(items=tuple(items), top_level=self.depth == 0)
        if self.log_debug:
            logger.debug("%sSuccessfully parsed expression.", self.depth * DELIMITER)
        return container

    @backtrack_if_none
    def parse_block(self) -> Optional[tree.BlockNode]:
        """Returns a node that represents a LookML block.

        Grammar: ``block`` ← ``key literal? "{" expression "}"``

        Returns:
            A node with the parsed block or None if the grammar doesn't match.

        """
        if self.log_debug:
            grammar = "[block] = key literal? '{' expression '}'"
            logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        key = self.parse_key()
        if key is None:
            return key

        if self.check(tokens.LiteralToken):
            token = self.consume()
            name: Optional[tree.SyntaxToken] = tree.SyntaxToken(
                token.value, token.line_number
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
                logger.debug("%sSuccessfully parsed block.", self.depth * DELIMITER)
            return block
        else:
            return None

    @backtrack_if_none
    def parse_pair(self) -> Optional[tree.PairNode]:
        """Returns a dictionary that represents a LookML key/value pair.

        Grammar: ``pair`` ← ``key value``

        Returns:
            A dictionary with the parsed pair or None if the grammar doesn't match.

        """
        if self.log_debug:
            grammar = "[pair] = key value"
            logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        key = self.parse_key()
        if key is None:
            return None
        value = self.parse_value(parse_prefix=True, parse_suffix=True)
        if value is None:
            return None

        pair = tree.PairNode(type=key[0], colon=key[1], value=value)
        logger.debug(self.depth * DELIMITER + "Successfully parsed pair.")
        return pair

    @backtrack_if_none
    def parse_key(self) -> Optional[Tuple[tree.SyntaxToken, tree.Colon]]:
        """Returns a syntax token that represents a literal key and colon character.

        Grammar: ``key`` ← ``literal ":"``

        Returns:
            A tuple of syntax tokens with the parsed key and colon or None if the
            grammar doesn't match.

        """
        if self.log_debug:
            grammar = "[key] = literal ':'"
            logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)
        prefix = self.consume_trivia()
        if self.check(tokens.LiteralToken):
            token = self.consume()
            key = tree.SyntaxToken(token.value, token.line_number, prefix=prefix)
        else:
            return None

        prefix = self.consume_trivia()
        if self.check(tokens.ValueToken):
            token = self.consume()
            suffix = self.consume_trivia()
            colon = tree.Colon(
                line_number=token.line_number, prefix=prefix, suffix=suffix
            )
        else:
            return None

        if self.log_debug:
            logger.debug("%sSuccessfully parsed key.", self.depth * DELIMITER)
        return key, colon

    @backtrack_if_none
    def parse_value(
        self, parse_prefix: bool = False, parse_suffix: bool = False
    ) -> Optional[tree.SyntaxToken]:
        """Returns a syntax token that represents a value.

        Grammar: ``value`` ← ``literal / quoted_literal / expression_block``

        Returns:
            A syntax token with the parsed value or None if the grammar doesn't match.

        """
        if self.log_debug:
            grammar = "[value] = literal / quoted_literal / expression_block"
            logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        prefix = self.consume_trivia() if parse_prefix else ""

        if self.check(tokens.LiteralToken):
            token = self.consume()
            suffix = self.consume_trivia() if parse_suffix else ""
            if self.log_debug:
                logger.debug("%sSuccessfully parsed value.", self.depth * DELIMITER)
            return tree.SyntaxToken(token.value, token.line_number, prefix, suffix)
        elif self.check(tokens.QuotedLiteralToken):
            token = self.consume()
            suffix = self.consume_trivia() if parse_suffix else ""
            if self.log_debug:
                logger.debug("%sSuccessfully parsed value.", self.depth * DELIMITER)
            return tree.QuotedSyntaxToken(
                token.value, token.line_number, prefix, suffix
            )
        elif self.check(tokens.ExpressionBlockToken):
            token = self.consume()
            expr_prefix, value, expr_suffix = utils.strip(token.value)
            prefix += expr_prefix

            if self.check(tokens.ExpressionBlockEndToken):
                self.advance()
            else:
                return None
            suffix = self.consume_trivia() if parse_suffix else ""
            if self.log_debug:
                logger.debug("%sSuccessfully parsed value.", self.depth * DELIMITER)
            return tree.ExpressionSyntaxToken(
                value, token.line_number, prefix, suffix, expr_suffix
            )
        else:
            return None

    @backtrack_if_none
    def parse_list(self) -> Optional[tree.ListNode]:
        """Returns a node that represents a LookML list.

        Grammar: ``list`` ← ``key "[" csv? "]"``

        Returns:
            A node with the parsed list or None if the grammar doesn't match

        """
        if self.log_debug:
            grammar = "[list] = key '[' csv? ']'"
            logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

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
        csv = csv or CommaSeparatedValues()

        if self.check(tokens.ListEndToken, skip_trivia=True):
            prefix = self.consume_trivia()
            self.advance()
            suffix = self.consume_trivia()
            right_bracket = tree.RightBracket(prefix=prefix, suffix=suffix)
            node = tree.ListNode(
                type=key[0],
                colon=key[1],
                left_bracket=left_bracket,
                items=csv.values,
                right_bracket=right_bracket,
                leading_comma=csv.leading_comma,
                trailing_comma=csv.trailing_comma,
            )
            if self.log_debug:
                logger.debug("%sSuccessfully parsed a list.", self.depth * DELIMITER)
            return node
        else:
            return None

    @backtrack_if_none
    def parse_csv(self) -> Optional[CommaSeparatedValues]:
        """Returns a CSV object that represents comma-separated LookML values.

        Returns:
            A container with the parsed values or None if the grammar doesn't match

        Grammar:
            ``csv`` ←
            ``","? (literal / quoted_literal) ("," (literal / quoted_literal))* ","?``

        """
        if self.log_debug:
            grammar = (
                '[csv] = ","? (literal / quoted_literal) '
                '("," (literal / quoted_literal))* ","?'
            )
            logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)

        # Set a flag to ensure that all items are of the same type (pair or literal)
        pair_mode: bool = False
        csv = CommaSeparatedValues()
        csv.leading_comma = self.parse_comma()

        # Parse the first value to set the list's type
        pair = self.parse_pair()
        if pair is not None:
            csv.append(pair)
            pair_mode = True
        elif self.check(
            tokens.LiteralToken, tokens.QuotedLiteralToken, skip_trivia=True
        ):
            value = self.parse_value(parse_prefix=True, parse_suffix=True)
            csv.append(value)
        else:
            return None

        # Parse to the closing bracket of the list
        while not self.check(tokens.ListEndToken, skip_trivia=True):
            if self.check(tokens.CommaToken):
                index = self.index
                self.advance()
                if self.check(tokens.ListEndToken, skip_trivia=True):
                    self.jump_to_index(index)  # Return to the comma so we can parse it
                    csv.trailing_comma = self.parse_comma()
                    break
            else:
                return None

            if pair_mode:
                pair = self.parse_pair()
                if pair is None:
                    return None
                else:
                    csv.append(pair)
            else:
                if self.check(
                    tokens.LiteralToken, tokens.QuotedLiteralToken, skip_trivia=True
                ):
                    value = self.parse_value(parse_prefix=True, parse_suffix=True)
                    csv.append(value)
                elif self.check(tokens.ListEndToken, skip_trivia=True):
                    break
                else:
                    return None

        if self.log_debug:
            logger.debug(
                "%sSuccessfully parsed comma-separated values.", self.depth * DELIMITER
            )
        return csv

    @backtrack_if_none
    def parse_comma(self) -> Optional[tree.Comma]:
        prefix = self.consume_trivia()
        if self.check(tokens.CommaToken):
            self.advance()
            if not self.check(tokens.ListEndToken, skip_trivia=True):
                suffix = self.consume_trivia()
            else:
                suffix = ""
            return tree.Comma(prefix=prefix, suffix=suffix)
        else:
            return None
