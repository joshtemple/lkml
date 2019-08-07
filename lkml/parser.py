r"""LookML grammar.

expression = (block / pair / list)*

block = key literal? "{" expression "}"

pair = key value

list = key "[" csv? "]"

csv = (literal / quoted_literal) ("," (literal / quoted_literal))* ","?

value = literal / quoted_literal / expression_block

key = literal ":"

expression_block = [^;]* ";;"

quoted_literal = '"' [^\"]+ '"'

literal = [0-9A-Za-z_]+

"""

import logging
from typing import Any, List, Optional, Sequence, Type

import lkml.tokens as tokens
from lkml.keys import PLURAL_KEYS

# Delimiter during logging to show parse tree depth
DELIMITER = ". "


class Parser:
    """LookML parser.

    Attributes:
        tokens (Sequence[tokens.Token]): validated tokens from input stream
        index (int): position in token sequence that is being evaluated
        progress (int): tracks position of parser as it is in progress of
            evaluating an expression
        logger (logging.Logger)
        depth (int): tracks level of recursion into nested expressions
        log_debug (bool): If debug messages should be logged

    """

    def __init__(self, stream: Sequence[tokens.Token]):
        """Instantiate Parser.

        Args:
            stream (Sequence[tokens.Token]): Lexed tokens to parse

        Raises:
            TypeError: Invalid token in stream

        """
        for token in stream:
            if not isinstance(token, tokens.Token):
                raise TypeError(
                    f"Type {type(token)} for {token} is not a valid token type."
                )
        self.tokens = stream
        self.index: int = 0
        self.progress: int = 0
        self.logger = logging.getLogger(__name__)
        self.depth: int = -1
        self.log_debug: bool = self.logger.isEnabledFor(logging.DEBUG)

    def jump_to_index(self, index: int):
        """Set parser index.

        Args:
            index (int): Position in stream to set

        """
        self.index = index

    def backtrack_if_none(method):  # noqa: D202
        """Backtrack when recursively descending.

        Args:
            method (Callable): Decorated method

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
        """Get token in LookML stream at the current index.

        Returns:
            tokens.Token: token at current index

        """
        return self.tokens[self.index]

    def advance(self, length: int = 1):
        """Move the parser index forward.

        Args:
            length (int, optional): Number of positions forward to move the index.
                Defaults to 1.

        """
        self.index += length

    def consume(self) -> tokens.Token:
        """Get the token at the current index and advance the index.

        Returns:
            tokens.Token: token at the current index

        """
        self.advance()
        return self.tokens[self.index - 1]

    def consume_token_value(self) -> Any:
        """Get the value of the token at the current index and advance the index.

        Returns:
            Any: token at the current index

        """
        token = self.consume()
        return token.value

    def check(self, *token_types: Type[tokens.Token]) -> bool:
        """Compare token at current index against specified token types.

        Raises:
            TypeError: one or more of the tokens passed as args are of an invalid type

        Returns:
            bool: True if current token matches one of the token_types

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

    def parse(self) -> List:
        """Wrapper for expression parser."""
        return self.parse_expression()

    def update_tree(self, target: dict, update: dict):
        """Add new elements to the parsed LookML dictionary.

        Args:
            target (dict): Parsed Lookml
            update (dict): New element to be added

        Raises:
            KeyError: If more than one element is added at one time
            KeyError: If key already exists and would overwrite existing value

        Examples:
            >>> update_tree({"name": "foo"}, {"sql_table_name": "foo.bar"})
                {"name": "foo", "sql_table_name": "foo.bar"}
            >>> update_tree({"name": "foo"}, {"dimension": {"sql": "${TABLE}.foo", "name": "foo"}})
                {"name": "foo", "dimensions": [{"sql": "${TABLE}.foo", "name": "foo"}]}
            >>> update_tree(
                    {"name": "foo", "dimensions": [{"sql": "${TABLE}.foo", "name": "foo"}]},
                    {"dimension": {"sql": "${TABLE}.bar", "name": "bar"}})
                {
                    "name": "foo",
                    "dimensions": [
                        {"sql": "${TABLE}.foo", "name": "foo"},
                        {"sql": "${TABLE}.bar", "name": "bar"},
                    ],
                }

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
        """Parse LookML token into Python object.

        Checks if expression is a block, pair, or list.

        Raises:
            SyntaxError: If parsed token does not match known LookML syntax

        Returns:
            dict: LookML expression as dictionary

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
        """Parse LookML expression block.

        Examples:
            Input (token stream):
            ------
            "dimension: foo {
                label: "Foo"
                sql: ${TABLE}.foo ;;
            }"

            Output (dictionary):
            -------
            {
                "name": "foo",
                "label": "Foo",
                "sql": "${TABLE}.foo"
            }

        Returns:
            Optional[dict]

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
        """Parse LookML key/value pair.

        Examples:
            Input (token stream):
            ------
            label: "Foo"

            Output (dictionary):
            -------
            {"label": "Foo"}

        Returns:
            Optional[dict]

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
        """Parse LookML token stream to find a key literal.

        If one is found, advance to the next index.

        Examples:
            Input (token stream):
            ------
            label: "Foo"

            Output (str):
            -------
            "label"

        Returns:
            Optional[str]

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
        """Parse LookML token stream to find a value.

        If one is found, advance to the next index.

        Examples:
            Input (token stream):
            ------
            1) "Foo"
            2) "${TABLE}.foo ;;"

            Output (str):
            -------
            1) "Foo"
            2) "${TABLE}.foo"

        Returns:
            Optional[str]

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
        """Parse LookML token stream to find a list.

        If one is found, advance to the next index.

        Examples:
            Input (token stream):
            ------
            "timeframes: [date, week]"

            Output (dictionary):
            -------
            {"timeframes": ["date", "week",]}

        Returns:
            Optional[str]

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
        """Parse comma separated list string into Python list.

        If one is found, advance to the next index.

        Examples:
        Input (token stream):
        ------
        1) "[date, week]"
        2) "['foo', 'bar']"

        Output (dictionary):
        -------
        1) ["date", "week",]
        2) ["foo", "bar",]

        Returns:
            Optional[list]

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
