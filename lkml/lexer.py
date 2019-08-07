"""Tokenize LookML."""
from typing import List, Tuple

import lkml.tokens as tokens
from lkml.keys import EXPR_BLOCK_KEYS

CH_MAPPING = {
    "\0": tokens.StreamEndToken,
    "{": tokens.BlockStartToken,
    "}": tokens.BlockEndToken,
    "[": tokens.ListStartToken,
    "]": tokens.ListEndToken,
    ",": tokens.CommaToken,
    ":": tokens.ValueToken,
    ";": tokens.ExpressionBlockEndToken,
}


class Lexer:
    """Tokenize LookML.

    Attributes:
        text (str): Raw LookML to parse, padded with null character to denote
            end of stream
        index (int): Position of lexer as it traverses through the text
        tokens (List[tokens.Token]): Tokenized elements from text
        line_number (int): Position of lexer (in lines) as it traverses
            through the text

    """

    def __init__(self, text: str):
        """Initialize Lexer.

        Args:
            text (str): raw LookML

        """
        self.text: str = text + "\0"
        self.index: int = 0
        self.tokens: List[tokens.Token] = []
        self.line_number: int = 1

    def peek(self) -> str:
        """Get character in LookML text at the current index.

        Returns:
            str: Character at current index

        """
        return self.text[self.index]

    def peek_multiple(self, length: int) -> str:
        """Get n characters in LookML text beginning at the current index.

        Args:
            length (int): Number of characters, n, to obtain

        Returns:
            str: LookML characters

        """
        return self.text[self.index : self.index + length]

    def advance(self, length: int = 1):
        """Move the lexer index forward.

        Args:
            length (int, optional): Number of positions forward to move the index.
                Defaults to 1.

        """
        self.index += length

    def consume(self) -> str:
        """Get the character at the current index and advance the index.

        Returns:
            str: LookML character at the current index

        """
        self.advance()
        return self.text[self.index - 1]

    def scan_until_token(self):
        """Advance through LookML until valid token is found."""
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
        """Tokenize LookML.

        Returns:
            Tuple[tokens.Token, ...]: Tokenized LookML

        """
        self.tokens.append(tokens.StreamStartToken(self.line_number))
        while True:
            self.scan_until_token()
            ch = self.peek()
            if ch == "\0":
                self.tokens.append(CH_MAPPING[ch](self.line_number))
                break
            elif ch == ";":
                if self.peek_multiple(2) == ";;":
                    self.advance(2)
                    self.tokens.append(CH_MAPPING[ch](self.line_number))
            elif ch == '"':
                self.advance()
                self.tokens.append(self.scan_quoted_literal())
            elif ch in CH_MAPPING.keys():
                self.advance()
                self.tokens.append(CH_MAPPING[ch](self.line_number))
            elif self.check_for_expression_block(self.peek_multiple(25)):
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

    @staticmethod
    def check_for_expression_block(string: str) -> bool:
        """Check if input is an expression block.

        Args:
            string (str): Input string

        Returns:
            bool: True if string is an expression block

        """
        return any(string.startswith(key + ":") for key in EXPR_BLOCK_KEYS)

    def scan_expression_block(self) -> tokens.ExpressionBlockToken:
        """Tokenize expression block.

        Returns:
            tokens.ExpressionBlockToken:

        """
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
        """Tokenize literals.

        Returns:
            tokens.LiteralToken

        """
        chars = ""
        while self.peek() not in "\0 \n\t:}{,]":
            chars += self.consume()
        return tokens.LiteralToken(chars, self.line_number)

    def scan_quoted_literal(self) -> tokens.QuotedLiteralToken:
        """Tokenize quoted literals.

        Returns:
            tokens.QuotedLiteralToken

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
