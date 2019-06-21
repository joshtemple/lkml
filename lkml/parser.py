import logging
from typing import List, Sequence, Type, Optional
import lkml.tokens as tokens

logger = logging.getLogger(f"{__name__}.parser")

"""

LookML grammar
---
expression = (block / pair / list)*

block = key key_name? "{" expression "}"

pair = key ":" value

list = key key_name? "[" ((literal / quoted_literal) ","?)+ "]"

value = quoted_literal / (literal sql_block_end?)

sql_block_end = ;;

key = literal

key_name = literal

quoted_literal = '"' [^\"]+ '"'

literal = [0-9A-Za-z_]+

"""


class Parser:
    def __init__(self, stream: Sequence[tokens.Token]):
        for token in stream:
            if not isinstance(token, tokens.Token):
                raise TypeError(
                    f"Type {type(token)} for {token} is not a valid token type."
                )
        self.tokens = stream
        logger.debug(tokens)
        self.index = 0

    def peek(self, length: int = 1):
        if length > 1:
            return self.tokens[self.index : self.index + length]
        else:
            return self.tokens[self.index]

    def advance(self, length: int = 1):
        logger.debug("\t" + str(self.tokens[self.index]))
        self.index += length

    def consume(self):
        token = self.peek()
        self.advance()
        return token

    def consume_token_value(self):
        token = self.consume()
        return token.value

    def check(self, *token_types: Type[tokens.Token]):
        logger.debug(f"Checking {self.peek()} against {token_types}")
        for token_type in token_types:
            if not issubclass(token_type, tokens.Token):
                raise TypeError(f"{token_type} is not a valid token type.")
        if type(self.peek()) in token_types:
            return True
        else:
            return False

    def parse(self) -> List:
        return self.parse_expression()

    def parse_expression(self) -> List:
        """expression = (block / pair / list)*"""
        logger.debug("Entering expression parser")
        expression = []
        if self.check(tokens.StreamStartToken):
            self.advance()
        while not self.check(tokens.StreamEndToken, tokens.BlockEndToken):
            if tokens.BlockStartToken in [type(token) for token in self.peek(4)]:
                block = self.parse_block()
                expression.append(block)
                continue
            if self.check(tokens.LiteralToken):
                pair = self.parse_pair()
                expression.append(pair)
                continue
            else:
                raise Exception("Syntax error.")

        logger.debug(f"Returning {expression} from expression parser")
        return expression

    def parse_block(self) -> Optional[dict]:
        """key key_name? '{' expression '}'"""
        logger.debug("Entering block parser")
        if self.check(tokens.LiteralToken):
            key = self.consume_token_value()
            if self.check(tokens.ValueToken):
                self.advance()
                if self.check(tokens.LiteralToken):
                    key_name = self.consume_token_value()
                if self.check(tokens.BlockStartToken):
                    self.advance()
                    expression = self.parse_expression()
                    if self.check(tokens.BlockEndToken):
                        self.advance()

        block = {key: {"name": key_name, "expression": expression}}
        logger.debug(f"Returning {block} from block parser")
        return block

    def parse_pair(self) -> Optional[dict]:
        """pair = key ':' value"""
        logger.debug("Entering pair parser")
        if self.check(tokens.LiteralToken):
            key = self.consume_token_value()
            if self.check(tokens.ValueToken):
                self.advance()
                value = self.parse_value()
                pair = {key: value}
                logger.debug(f"Returning {pair} from pair parser")
                return pair

    def parse_value(self) -> Optional[str]:
        """value = quoted_literal / (literal sql_block_end?)"""
        logger.debug("Entering value parser")
        if self.check(tokens.QuotedLiteralToken):
            value = self.consume_token_value()
            logger.debug(f"Returning {value} from expression parser")
            return value
        elif self.check(tokens.LiteralToken):
            value = self.consume_token_value()
            if self.check(tokens.SqlEndToken):
                self.advance()
            logger.debug(f"Returning {value} from expression parser")
            return value

    def parse_list(self):
        pass
