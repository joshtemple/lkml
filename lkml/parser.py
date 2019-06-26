import logging
from typing import List, Sequence, Type, Optional, Any, Union
import lkml.tokens as tokens

"""

LookML grammar
---
expression = (block / pair / list)*

block = key literal? "{" expression "}"

pair = key value

list = key "[" csv? "]"

csv = (literal / quoted_literal) ("," (literal / quoted_literal))*

value = literal / quoted_literal / expression_block

key = literal ":"

expression_block = [^;]* ";;"

quoted_literal = '"' [^\"]+ '"'

literal = [0-9A-Za-z_]+

"""

# Delimiter during logging to show parse tree depth
DELIMITER = ". "


class Parser:
    def __init__(self, stream: Sequence[tokens.Token]):
        for token in stream:
            if not isinstance(token, tokens.Token):
                raise TypeError(
                    f"Type {type(token)} for {token} is not a valid token type."
                )
        self.tokens = stream
        self.index = 0
        self.logger = logging.getLogger(__name__)
        self.depth = -1

    def jump_to_index(self, index: int):
        self.index = index

    def backtrack_if_none(method):
        def wrapper(self, *args, **kwargs):
            mark = self.index
            self.depth += 1
            result = method(self, *args, **kwargs)
            self.depth -= 1
            if result is None:
                self.jump_to_index(mark)
            return result

        return wrapper

    def peek(self) -> tokens.Token:
        return self.tokens[self.index]

    def advance(self, length: int = 1):
        self.index += length

    def consume(self) -> tokens.Token:
        token = self.peek()
        self.advance()
        return token

    def consume_token_value(self) -> Any:
        token = self.consume()
        return token.value

    def check(self, *token_types: Type[tokens.Token]) -> bool:
        self.logger.debug(
            (1 + self.depth) * DELIMITER + f"Check {self.peek()} == "
            f"{' or '.join(t.__name__ for t in token_types)}"
        )
        for token_type in token_types:
            if not issubclass(token_type, tokens.Token):
                raise TypeError(f"{token_type} is not a valid token type.")
        if type(self.peek()) in token_types:
            return True
        else:
            return False

    def parse(self) -> List:
        return self.parse_expression()

    @staticmethod
    def update_tree(target, update):
        keys = tuple(update.keys())
        if len(keys) > 1:
            raise ValueError("Dictionary to update with cannot have multiple keys.")
        key = keys[0]
        if key.rstrip("s") in [
            "view",
            "measure",
            "dimension",
            "dimension_group",
            "filter",
            "access_filter",
            "bind_filters",
            "map_layer",
            "parameter",
            "set",
            "column",
            "derived_column",
            "include",
            "explore",
            "link",
            "when",
            "allowed_value",
            "named_value_format",
            "join",
            "datagroup",
            "access_grant",
        ]:
            plural_key = key.rstrip("s") + "s"
            if plural_key in target.keys():
                target[plural_key].append(update[key])
            else:
                target[plural_key] = [update[key]]
        elif key in target.keys():
            raise KeyError(
                f'Key "{key}" already exists in tree '
                "and would overwrite the existing value."
            )
        else:
            target[key] = update[key]

    @backtrack_if_none
    def parse_expression(self) -> dict:
        grammar = "[expression] = (block / pair / list)*"
        self.logger.debug(self.depth * DELIMITER + f"Try to parse {grammar}")
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
                expression.update(pair)
                continue

            list = self.parse_list()
            if list is not None:
                expression.update(list)
                continue

            raise SyntaxError("Unable to find a matching expression.")

        self.logger.debug(self.depth * DELIMITER + "Successfully parsed expression.")
        return expression

    @backtrack_if_none
    def parse_block(self) -> Optional[dict]:
        grammar = "[block] = key literal? '{' expression '}'"
        self.logger.debug(self.depth * DELIMITER + f"Try to parse {grammar}")

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
        if expression is None:
            return expression

        if self.check(tokens.BlockEndToken):
            self.advance()

            block = {key: expression}
            if literal:
                block[key]["name"] = literal

            self.logger.debug(self.depth * DELIMITER + "Successfully parsed block.")
            return block
        else:
            return None

    @backtrack_if_none
    def parse_pair(self) -> Optional[dict]:
        grammar = "[pair] = key value"
        self.logger.debug(self.depth * DELIMITER + f"Try to parse {grammar}")

        key = self.parse_key()
        if key is None:
            return key

        value = self.parse_value()
        if value is None:
            return value

        pair = {key: value}
        self.logger.debug(self.depth * DELIMITER + "Successfully parsed pair.")
        return pair

    @backtrack_if_none
    def parse_key(self) -> Optional[str]:
        grammar = "[key] = literal ':'"
        self.logger.debug(self.depth * DELIMITER + f"Try to parse {grammar}")
        if self.check(tokens.LiteralToken):
            key = self.consume_token_value()
        else:
            return None

        if self.check(tokens.ValueToken):
            self.advance()
        else:
            return None

        self.logger.debug(self.depth * DELIMITER + "Successfully parsed key.")
        return key

    @backtrack_if_none
    def parse_value(self) -> Optional[str]:
        grammar = "[value] = literal / quoted_literal / expression_block"
        self.logger.debug(self.depth * DELIMITER + f"Try to parse {grammar}")
        if self.check(tokens.QuotedLiteralToken, tokens.LiteralToken):
            value = self.consume_token_value()
            self.logger.debug(self.depth * DELIMITER + "Successfully parsed value.")
            return value
        elif self.check(tokens.ExpressionBlockToken):
            value = self.consume_token_value()
            if self.check(tokens.ExpressionBlockEndToken):
                self.advance()
            else:
                return None
            self.logger.debug(self.depth * DELIMITER + "Successfully parsed value.")
            return value
        else:
            return None

    @backtrack_if_none
    def parse_list(self) -> Optional[dict]:
        grammar = "[list] = key '[' csv? ']'"
        self.logger.debug(self.depth * DELIMITER + f"Try to parse {grammar}")

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
            self.logger.debug(self.depth * DELIMITER + "Successfully parsed a list.")
            return list
        else:
            return None

    @backtrack_if_none
    def parse_csv(self) -> Optional[list]:
        grammar = "[csv] = (literal / quoted_literal) (" " (literal / quoted_literal))*"
        self.logger.debug(self.depth * DELIMITER + f"Try to parse {grammar}")
        values = []

        if self.check(tokens.LiteralToken):
            values.append(self.consume_token_value())
        elif self.check(tokens.QuotedLiteralToken):
            values.append(self.consume_token_value())
        else:
            return None

        while not self.check(tokens.ListEndToken):
            if self.check(tokens.CommaToken):
                self.advance()
            else:
                return None

            if self.check(tokens.LiteralToken):
                values.append(self.consume_token_value())
            elif self.check(tokens.QuotedLiteralToken):
                values.append(self.consume_token_value())
            else:
                return None

        self.logger.debug(
            self.depth * DELIMITER + "Successfully parsed comma-separated values."
        )
        return values
