"""LookML tokens."""


class Token:
    """Base class for LookML tokens.

    Attributes:
        id (str): Token ID
        value (str): Token value

    """

    id: str = "<base token>"
    value: str

    def __init__(self, line_number: int):
        """Initialize Token.

        Args:
            line_number (int): Line on which token occurs.

        """
        self.line_number = line_number

    def __eq__(self, other):
        """Equality check."""
        return self.__class__ == other.__class__

    def __repr__(self):
        """Token representation.

        Truncated at 25 characters.

        """
        value = getattr(self, "value", "").strip()
        value = (value[:25].rstrip() + " ... ") if len(value) > 25 else value
        return f"{self.__class__.__name__}({value})"


class ContentToken(Token):
    """LookML token containing custom content."""

    id = "<base ContentToken>"

    def __init__(self, value: str, line_number: int):
        """Instantiate ContentToken.

        Args:
            value (str): Expression block content
            line_number (int): line from LookML stream containing expression block

        """
        self.value = value
        self.line_number = line_number

    def __eq__(self, other):
        """Equality check."""
        return self.id == other.id and self.value == other.value


class StreamStartToken(Token):
    """Beginning of LookML stream."""

    id = "<stream start>"


class StreamEndToken(Token):
    """End of LookML stream."""

    id = "<stream end>"


class BlockStartToken(Token):
    """Beginning of field block."""

    id = "{"


class BlockEndToken(Token):
    """End of field block."""

    id = "}"


class ValueToken(Token):
    """Key/Value separator."""

    id = ":"


class ExpressionBlockEndToken(Token):
    """End of SQL expression block."""

    id = ";;"


class DotToken(Token):
    """Dot token."""

    id = "."


class CommaToken(Token):
    """Comma token."""

    id = ","


class ListStartToken(Token):
    """Beginning of list."""

    id = "["


class ListEndToken(Token):
    """End of list."""

    id = "]"


class ExpressionBlockToken(ContentToken):
    """LookML expression block."""

    id = "<expression block>"


class LiteralToken(ContentToken):
    """LookML literal."""

    id = "<literal>"


class QuotedLiteralToken(ContentToken):
    """LookML quoted literal."""

    id = "<quoted literal>"
