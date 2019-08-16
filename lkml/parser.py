"""Parses a sequence of tokenized LookML into a Python object."""

import logging
from typing import Optional, Sequence, Type

import lkml.tokens as tokens
from lkml.keys import PLURAL_KEYS

# Delimiter character used during logging to show the depth of nesting
DELIMITER = ". "


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

    def backtrack_if_none(method):  # noqa: D202
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

        def wrapper(self, *args, **kwargs):
            mark = self.index
            self.depth += 1
            result = method(self, *args, **kwargs)
            self.depth -= 1
            if result is None:
                self.progress = (
                    self.index if self.index > self.progress else self.progress
                )
                self.jump_to_index(mark)
            return result

        return wrapper

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

    def consume_token_value(self) -> Optional[str]:
        """Returns the value of the current index token, advancing the index 1 token."""
        token = self.consume()
        return token.value

    def check(self, *token_types: Type[tokens.Token]) -> bool:
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
        if type(self.peek()) in token_types:
            return True
        else:
            return False

    def parse(self) -> dict:
        """Main method of this class and a wrapper for the expression parser."""
        return self.parse_expression()

    def update_tree(self, target: dict, update: dict):
        """Add one dictionary to an existing dictionary, handling certain repeated keys.

        This method is primarily responsible for handling repeated keys in LookML like
        `dimension` or `set`, which can exist more than once in LookML but cannot be
        repeated in a Python dictionary.

        This method checks the list of valid repeated keys and combines the values of
        that key in `target` and/or `update` into a list and assigns a plural key (e.g.
        `dimensions` instead of `dimension`).

        Args:
            target: Existing dictionary of parsed LookML
            update: New dictionary to be added to target

        Raises:
            KeyError: If `update` has more than one key
            KeyError: If the key in `update` already exists and would overwrite existing

        Examples:
            >>> from pprint import pprint
            >>> parser = Parser((tokens.Token(1),))

            Updating the target with a non-existing, unique key.

            >>> target = {"name": "foo"}
            >>> update = {"sql_table_name": "foo.bar"}
            >>> parser.update_tree(target, update)
            >>> pprint(target)
            {'name': 'foo', 'sql_table_name': 'foo.bar'}

            Updating the target with a non-existing, repeatable key.

            >>> target = {"name": "foo"}
            >>> update = {"dimension": {"sql": "${TABLE}.foo", "name": "foo"}}
            >>> parser.update_tree(target, update)
            >>> pprint(target)
            {'dimensions': [{'name': 'foo', 'sql': '${TABLE}.foo'}], 'name': 'foo'}

            Updating the target with an existing, repeatable key.

            >>> target = {"name": "foo", "dimensions": [{"sql": "${TABLE}.foo", "name": "foo"}]}
            >>> update = {"dimension": {"sql": "${TABLE}.bar", "name": "bar"}}
            >>> parser.update_tree(target, update)
            >>> pprint(target)
            {'dimensions': [{'name': 'foo', 'sql': '${TABLE}.foo'},
                            {'name': 'bar', 'sql': '${TABLE}.bar'}],
             'name': 'foo'}

        """
        keys = tuple(update.keys())
        if len(keys) > 1:
            raise KeyError("Dictionary to update with cannot have multiple keys.")
        key = keys[0]
        stripped_key = key.rstrip("s")
        if stripped_key in PLURAL_KEYS:
            plural_key = stripped_key + "s"
            if plural_key in target.keys():
                target[plural_key].append(update[key])
            else:
                target[plural_key] = [update[key]]
        elif key in target.keys():
            if self.depth == 0:
                self.logger.warning(
                    'Multiple declarations of top-level key "%s" found. '
                    "Using the last-declared value.",
                    key,
                )
                target[key] = update[key]
            else:
                raise KeyError(
                    f'Key "{key}" already exists in tree '
                    "and would overwrite the existing value."
                )
        else:
            target[key] = update[key]

    @backtrack_if_none
    def parse_expression(self) -> dict:
        """Returns a parsed LookML dictionary from a sequence of tokens.

        Raises:
            SyntaxError: If unable to find a matching grammar rule for the stream

        Grammar:
            expression ← (block / pair / list)*

        """
        if self.log_debug:
            grammar = "[expression] = (block / pair / list)*"
            self.logger.debug("%sTry to parse %s", self.depth * DELIMITER, grammar)
        expression: dict = {}
        if self.check(tokens.StreamStartToken):
            self.advance()
        while not self.check(tokens.StreamEndToken, tokens.BlockEndToken):
            block = self.parse_block()
            if block is not None:
                self.update_tree(expression, block)
                continue

            pair = self.parse_pair()
            if pair is not None:
                self.update_tree(expression, pair)
                continue

            list = self.parse_list()
            if list is not None:
                expression.update(list)
                continue

            token = self.tokens[self.progress]
            raise SyntaxError(
                f"Unable to find a matching expression for '{token.id}' "
                f"on line {token.line_number}"
            )

        if self.log_debug:
            self.logger.debug(
                "%sSuccessfully parsed expression.", self.depth * DELIMITER
            )
        return expression

    @backtrack_if_none
    def parse_block(self) -> Optional[dict]:
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
            literal = self.consume_token_value()
        else:
            literal = None

        if self.check(tokens.BlockStartToken):
            self.advance()
        else:
            return None

        expression = self.parse_expression()

        if self.check(tokens.BlockEndToken):
            self.advance()

            block = {key: expression}
            if literal:
                block[key]["name"] = literal

            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed block.", self.depth * DELIMITER
                )
            return block
        else:
            return None

    @backtrack_if_none
    def parse_pair(self) -> Optional[dict]:
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

        pair = {key: value}
        self.logger.debug(self.depth * DELIMITER + "Successfully parsed pair.")
        return pair

    @backtrack_if_none
    def parse_key(self) -> Optional[str]:
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
        if self.check(tokens.LiteralToken):
            key = self.consume_token_value()
        else:
            return None

        if self.check(tokens.ValueToken):
            self.advance()
        else:
            return None

        if self.log_debug:
            self.logger.debug("%sSuccessfully parsed key.", self.depth * DELIMITER)
        return key

    @backtrack_if_none
    def parse_value(self) -> Optional[str]:
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
        if self.check(tokens.QuotedLiteralToken, tokens.LiteralToken):
            value = self.consume_token_value()
            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed value.", self.depth * DELIMITER
                )
            return value
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
            return value
        else:
            return None

    @backtrack_if_none
    def parse_list(self) -> Optional[dict]:
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

        if self.check(tokens.ListStartToken):
            self.advance()
        else:
            return None

        csv = self.parse_csv()
        csv = csv if csv else []

        if self.check(tokens.ListEndToken):
            self.advance()
            list = {key: csv}
            if self.log_debug:
                self.logger.debug(
                    "%sSuccessfully parsed a list.", self.depth * DELIMITER
                )
            return list
        else:
            return None

    @backtrack_if_none
    def parse_csv(self) -> Optional[list]:
        """Returns a list that represents comma-separated LookML values.

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
        values = []

        if self.check(tokens.LiteralToken, tokens.QuotedLiteralToken):
            values.append(self.consume_token_value())
        else:
            return None

        while not self.check(tokens.ListEndToken):
            if self.check(tokens.CommaToken):
                self.advance()
            else:
                return None

            if self.check(tokens.LiteralToken, tokens.QuotedLiteralToken):
                values.append(self.consume_token_value())
            elif self.check(tokens.ListEndToken):
                break
            else:
                return None

        if self.log_debug:
            self.logger.debug(
                "%sSuccessfully parsed comma-separated values.", self.depth * DELIMITER
            )
        return values
