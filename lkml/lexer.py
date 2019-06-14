from typing import List
import lkml.tokens as tokens


class Lexer:
    def __init__(self, text):
        self.text = text + "\0"
        self.scanned = False
        self.index = 0
        self.tokens = []

    def peek(self, length=1):
        return self.text[self.index : self.index + length]

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
            elif ch == "$":
                if self.peek(2) == "${":
                    self.advance(2)
                    self.tokens.append(tokens.ReferenceStartToken())
            elif ch == "{":
                self.advance()
                self.tokens.append(tokens.BlockStartToken())
            elif ch == "}":
                self.advance()
                self.tokens.append(tokens.BlockEndToken())
            elif ch == ":":
                self.advance()
                self.tokens.append(tokens.ValueToken())
            elif ch == ";":
                if self.peek(2) == ";;":
                    self.advance(2)
                    self.tokens.append(tokens.SqlEndToken())
            elif ch == '"':
                self.advance()
                self.tokens.append(self.scan_quoted_literal())
            else:
                self.tokens.append(self.scan_literal())
        self.scanned = True

    def scan_reference(self):
        chars = ""
        while self.peek() != "}":
            chars += self.consume()
        self.advance()
        return tokens.LiteralToken(chars)

    def scan_literal(self):
        chars = ""
        while self.peek() not in "\0 \r\n\t:}":
            chars += self.consume()
        return tokens.LiteralToken(chars)

    def scan_quoted_literal(self):
        chars = ""
        while self.peek() != '"':
            chars += self.consume()
        self.advance()
        return tokens.QuotedLiteralToken(chars)


if __name__ == "__main__":
    string = """view: view_name {
    sql_table_name: "schema.table_name"
    dimension: dimension_name {
        label: "Dimension Label"
        type: string
        sql: ${TABLE}.dimension_name ;;
    }
    measure: avg_dimension_name {
        label: "Average Dimension Label"
        type: avg
        sql: ${dimension_name} ;;
    }
}
    """
    print(string)
    l = Lexer(string)
    l.scan()
    print(l.tokens)
