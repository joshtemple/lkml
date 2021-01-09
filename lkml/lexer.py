"""Splits a LookML string into a sequence of tokens."""

from typing import List, Tuple

import lkml.tokens as tokens
from lkml.keys import CHARACTER_TO_TOKEN, EXPR_BLOCK_KEYS


class Lexer:
    """Splits a LookML string into a sequence of tokens.

    Attributes:
        text: Raw LookML to parse, padded with null character to denote end of stream
        index: Position of lexer in characters as it traverses the text
        tokens: Sequence of tokens that contain the relevant chunks of text
        line_number: Position of lexer in lines as it traverses the text

    """

    def __init__(self, text: str):
        """Initializes the Lexer with a LookML string and sets the index.

        Args:
            text: LookML string to be lexed

        """
        self.text: str = text + "\0"
        self.index: int = 0
        self.tokens: List[tokens.Token] = []
        self.line_number: int = 1

    def peek(self) -> str:
        """Returns the character at the current index of the text being lexed."""
        return self.text[self.index]

    def peek_multiple(self, length: int) -> str:
        """Returns the next n characters from the current index in the text being lexed.

        Args:
            length: The number of characters to return

        """
        return self.text[self.index : self.index + length]

    def advance(self, length: int = 1) -> None:
        """Moves the index forward by n characters.

        Args:
            length: The number of positions forward to move the index.

        """
        self.index += length

    def consume(self) -> str:
        """Returns the current index character and advances the index 1 character."""
        self.advance()
        return self.text[self.index - 1]

    def scan(self) -> Tuple[tokens.Token, ...]:
        """Tokenizes LookML into a sequence of tokens.

        This method skips through the text being lexed until it finds a character that
        indicates the start of a new token. It consumes the relevant characters and adds
        the tokens to a sequence until it reaches the end of the text.
        """
        self.tokens.append(tokens.StreamStartToken(self.line_number))
        while True:
            ch = self.peek()
            if ch == "\0":
                self.tokens.append(CHARACTER_TO_TOKEN[ch](self.line_number))
                break
            elif ch in "\n\t ":
                self.tokens.append(self.scan_whitespace())
            elif ch == "#":
                self.advance()
                self.tokens.append(self.scan_comment())
            elif ch == ";":
                if self.peek_multiple(2) == ";;":
                    self.advance(2)
                    self.tokens.append(CHARACTER_TO_TOKEN[ch](self.line_number))
            elif ch == '"':
                self.advance()
                self.tokens.append(self.scan_quoted_literal())
            elif ch in CHARACTER_TO_TOKEN.keys():
                self.advance()
                self.tokens.append(CHARACTER_TO_TOKEN[ch](self.line_number))
            elif self.check_for_expression_block(self.peek_multiple(25)):
                # TODO: Handle edges here with whitespace and comments
                self.tokens.append(self.scan_literal())
                self.advance()
                self.tokens.append(tokens.ValueToken(self.line_number))
                self.tokens.append(self.scan_expression_block())
            else:
                # TODO: This should actually check for valid literals first
                # and throw an error if it doesn't match
                self.tokens.append(self.scan_literal())

        return tuple(self.tokens)

    @staticmethod
    def check_for_expression_block(string: str) -> bool:
        """Returns True if the input string is an expression block."""
        return any(string.startswith(key + ":") for key in EXPR_BLOCK_KEYS)

    def scan_whitespace(self) -> tokens.WhitespaceToken:
        r"""Returns a token from one or more whitespace characters.

        Example:
            >>> lexer = Lexer("\n\n\t Hello")
            >>> lexer.scan_whitespace()
            WhitespaceToken('\n\n\t ')

        """
        chars = ""
        while self.peek() in "\n\t ":
            if self.peek() == "\n":
                self.line_number += 1
            chars += self.consume()
        return tokens.WhitespaceToken(chars, self.line_number)

    def scan_comment(self) -> tokens.CommentToken:
        r"""Returns a token from a comment.

        The initial pound (#) character is consumed in the scan method, so this
        method only scans for a newline or end of file to indicate the end of the token.

        The pound character is added back to the beginning to the token to emphasize
        the importance of any leading whitespace that follows.

        Example:
            >>> lexer = Lexer(" Disregard this line\n")
            >>> lexer.scan_comment()
            CommentToken(# Disregard this line)

        """
        chars = "#"
        while self.peek() not in "\0\n":
            chars += self.consume()
        return tokens.CommentToken(chars, self.line_number)

    def scan_expression_block(self) -> tokens.ExpressionBlockToken:
        """Returns an token from an expression block string.

        This method strips any trailing whitespace from the expression string, since
        Looker usually adds an extra space before the `;;` terminal.

        Example:
            >>> lexer = Lexer("SELECT * FROM ${TABLE} ;;")
            >>> lexer.scan_expression_block()
            ExpressionBlockToken(SELECT * FROM ${TABLE})

        """
        chars = ""
        while self.peek_multiple(2) != ";;":
            if self.peek() == "\n":
                self.line_number += 1
            chars += self.consume()
        return tokens.ExpressionBlockToken(chars, self.line_number)

    def scan_literal(self) -> tokens.LiteralToken:
        """Returns a token from a literal string.

        Example:
            >>> lexer = Lexer("yes")
            >>> lexer.scan_literal()
            LiteralToken(yes)

        """
        chars = ""
        while self.peek() not in "\0 \n\t:}{,]":
            chars += self.consume()
        return tokens.LiteralToken(chars, self.line_number)

    def scan_quoted_literal(self) -> tokens.QuotedLiteralToken:
        """Returns a token from a quoted literal string.

        The initial double quote character is consumed in the scan method, so this
        method only scans for the trailing quote to indicate the end of the token.

        Example:
            >>> lexer = Lexer('Label"')
            >>> lexer.scan_quoted_literal()
            QuotedLiteralToken(Label)

        """
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
