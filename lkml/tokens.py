class Token:
    id = "<base token>"
    value: str

    def __init__(self, line_number: int):
        self.line_number = line_number

    def __eq__(self, other):
        return self.__class__ == other.__class__

    def __repr__(self):
        value = getattr(self, "value", "").strip()
        value = (value[:25].rstrip() + " ...") if len(value) > 25 else value
        return f"{self.__class__.__name__}({value})"


class StreamStartToken(Token):
    id = "<stream start>"


class StreamEndToken(Token):
    id = "<stream end>"


class BlockStartToken(Token):
    id = "{"


class BlockEndToken(Token):
    id = "}"


class ValueToken(Token):
    id = ":"


class ExpressionBlockEndToken(Token):
    id = ";;"


class DotToken(Token):
    id = "."


class CommaToken(Token):
    id = ","


class ListStartToken(Token):
    id = "["


class ListEndToken(Token):
    id = "]"


class ExpressionBlockToken(Token):
    id = "<expression block>"

    def __init__(self, value, line_number):
        self.value = value
        self.line_number = line_number

    def __eq__(self, other):
        return self.id == other.id and self.value == other.value


class LiteralToken(Token):
    id = "<literal>"

    def __init__(self, value, line_number):
        self.value = value
        self.line_number = line_number

    def __eq__(self, other):
        return self.id == other.id and self.value == other.value


class QuotedLiteralToken(Token):
    id = "<quoted literal>"

    def __init__(self, value, line_number):
        self.value = value
        self.line_number = line_number

    def __eq__(self, other):
        return self.id == other.id and self.value == other.value
