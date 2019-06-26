from typing import Tuple, List
import lkml.tokens as tokens


class Lexer:
    def __init__(self, text):
        self.text = text + "\0"
        self.index = 0
        self.tokens = []
        self.line_number = 1

    def peek(self) -> str:
        return self.text[self.index]

    def peek_multiple(self, length: int) -> str:
        return self.text[self.index : self.index + length]

    def advance(self, length: int = 1):
        self.index += length

    def consume(self) -> str:
        self.advance()
        return self.text[self.index - 1]

    def scan_until_token(self):
        found = False
        while not found:
            while self.peek() in "\n\t ":
                if self.peek() == "\n":
                    self.line_number += 1
                self.advance()
            if self.peek() == "#":
                while self.peek() not in "\0\n":
                    self.advance()
            else:
                found = True

    def scan(self) -> Tuple[tokens.Token, ...]:
        self.tokens.append(tokens.StreamStartToken(self.line_number))
        while True:
            self.scan_until_token()
            ch = self.peek()
            if ch == "\0":
                self.tokens.append(tokens.StreamEndToken(self.line_number))
                break
            elif ch == "{":
                self.advance()
                self.tokens.append(tokens.BlockStartToken(self.line_number))
            elif ch == "}":
                self.advance()
                self.tokens.append(tokens.BlockEndToken(self.line_number))
            elif ch == "[":
                self.advance()
                self.tokens.append(tokens.ListStartToken(self.line_number))
            elif ch == "]":
                self.advance()
                self.tokens.append(tokens.ListEndToken(self.line_number))
            elif ch == ",":
                self.advance()
                self.tokens.append(tokens.CommaToken(self.line_number))
            elif ch == ":":
                self.advance()
                self.tokens.append(tokens.ValueToken(self.line_number))
            elif ch == ";":
                if self.peek_multiple(2) == ";;":
                    self.advance(2)
                    self.tokens.append(tokens.ExpressionBlockEndToken(self.line_number))
            elif ch == '"':
                self.advance()
                self.tokens.append(self.scan_quoted_literal())
            elif (
                self.peek_multiple(3) == "sql"
                or self.peek_multiple(4) == "html"
                or self.peek_multiple(24) == "expression_custom_filter"
            ):
                self.tokens.append(self.scan_literal())
                self.scan_until_token()
                self.advance()
                self.tokens.append(tokens.ValueToken(self.line_number))
                self.scan_until_token()
                self.tokens.append(self.scan_expression_block())
            else:
                # TODO: This should actually check for valid literals first
                # and throw an error if it doesn't match
                self.tokens.append(self.scan_literal())

        return tuple(self.tokens)

    def scan_expression_block(self) -> tokens.ExpressionBlockToken:
        chars = ""
        while self.peek_multiple(2) != ";;":
            if self.peek() == "\n":
                self.line_number += 1
            chars += self.consume()
        # Strip any trailing whitespace from the expression
        # Usually there is an extra space before the ;;
        chars = chars.rstrip()
        return tokens.ExpressionBlockToken(chars, self.line_number)

    def scan_literal(self) -> tokens.LiteralToken:
        chars = ""
        while self.peek() not in "\0 \n\t:}{,]":
            chars += self.consume()
        return tokens.LiteralToken(chars, self.line_number)

    def scan_quoted_literal(self) -> tokens.QuotedLiteralToken:
        # TODO: Check and see if literals can be single-quoted
        chars = ""
        while True:
            ch = self.peek()
            if ch == '"':
                break
            elif ch == "\\":
                chars += self.consume()  # Extra consume to skip the escaped character
            elif ch == "\n":
                self.line_number += 1
            chars += self.consume()
        self.advance()
        return tokens.QuotedLiteralToken(chars, self.line_number)
