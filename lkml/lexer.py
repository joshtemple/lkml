from typing import List
import lkml.tokens as tokens


class Lexer:
    def __init__(self, text):
        self.text = text + "\0"
        self.scanned = False
        self.index = 0
        self.tokens = []

    def peek(self, length=0):
        return self.text[self.index : self.index + length + 1]

    def advance(self, length=1):
        self.index += length

    def consume(self):
        ch = self.peek()
        self.advance()
        return ch

    def scan_until_token(self):
        found = False
        while not found:
            while self.peek() in "\r\n\t ":
                self.advance()
            if self.peek() == "#":
                while self.peek() not in "\0\r\n":
                    self.advance()
            else:
                found = True

    def scan(self):
        self.tokens.append(tokens.StreamStartToken())
        while True:
            self.scan_until_token()
            ch = self.peek()
            if ch == "\0":
                self.tokens.append(tokens.StreamEndToken())
                break
            elif ch == "{":
                self.advance()
                self.tokens.append(tokens.BlockStartToken())
            elif ch == "}":
                self.advance()
                self.tokens.append(tokens.BlockEndToken())
            elif ch == ":":
                self.advance()
                self.tokens.append(tokens.ValueToken())
            elif ch == '"':
                self.advance()
                self.tokens.append(self.scan_quoted_literal())
            else:
                self.tokens.append(self.scan_literal())
        self.scanned = True

    def scan_literal(self):
        chars = ""
        while self.peek() not in "\0 \r\n\t:":
            chars += self.consume()
        return tokens.LiteralToken(chars)

    def scan_quoted_literal(self):
        chars = ""
        while self.peek() != '"':
            chars += self.consume()
        self.advance()
        return tokens.QuotedLiteralToken(chars)


if __name__ == "__main__":
    string = '{ key: "quoted literal value" }'
    l = Lexer(string)
    l.scan()
    print(l.tokens)
