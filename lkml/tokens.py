"""Tokens used by the lexer to tokenize LookML."""


class Token:
    """Base class for LookML tokens, lexed from LookML strings."""

    id: str = "<base token>"
    value: str

    def __init__(self, line_number: int):
        """Initializes a Token.

        Args:
            line_number: The corresponding line in the text where this token begins

        """
        self.line_number: int = line_number

    def __eq__(self, other):
        """Compare one Token to another by their type."""
        return self.__class__ == other.__class__

    def __repr__(self):
        """Returns the token's string representation, truncated to 25 characters.

        If the token has a `value` attribute, include that in the output.

        Examples:
            >>> token = Token(1)
            >>> token.__repr__()
            'Token()'

            >>> token.value = 'A string value'
            >>> token.__repr__()
            'Token(A string value)'

            >>> token.value = 'A very, very, very long string value'
            >>> token.__repr__()
            'Token(A very, very, very long s ... )'

        """
        value = getattr(self, "value", "").strip()
        value = (value[:25].rstrip() + " ... ") if len(value) > 25 else value
        return f"{self.__class__.__name__}({value})"


class ContentToken(Token):
    """Base class for LookML tokens that contain a string of content."""

    def __init__(self, value: str, line_number: int):
        """Initializes a ContentToken with string content.

        Args:
            value: A string value for the token's content
            line_number: The corresponding line in the text where this token begins

        """
        self.value: str = value
        self.line_number: int = line_number

    def __eq__(self, other):
        """Compare one ContentToken to another by their values."""
        return self.id == other.id and self.value == other.value


class StreamStartToken(Token):
    """Represents the start of a stream of characters."""

    id = "<stream start>"


class StreamEndToken(Token):
    """Represents the end of a stream of characters."""

    id = "<stream end>"


class BlockStartToken(Token):
    """Represents the start of a block."""

    id = "{"


class BlockEndToken(Token):
    """Represents the end of a block."""

    id = "}"


class ValueToken(Token):
    """Separates a key from a value."""

    id = ":"


class ExpressionBlockEndToken(Token):
    """Represents the end of an expression block."""

    id = ";;"


class CommaToken(Token):
    """Separates elements in a list."""

    id = ","


class ListStartToken(Token):
    """Represents the start of a list."""

    id = "["


class ListEndToken(Token):
    """Represents the end of a list."""

    id = "]"


class TriviaToken(ContentToken):
    """Represents a comment or whitespace."""


class WhitespaceToken(TriviaToken):
    """Represents one or more whitespace characters."""

    id = "<whitespace>"

    def __repr__(self):
        return f"{self.__class__.__name__}({repr(self.value)})"


class CommentToken(TriviaToken):
    """Represents a comment."""

    id = "<comment>"


class ExpressionBlockToken(ContentToken):
    """Contains the value of an expression block."""

    id = "<expression block>"


class LiteralToken(ContentToken):
    """Contains the value of an unquoted literal."""

    id = "<literal>"


class QuotedLiteralToken(ContentToken):
    """Contains the value of a quoted literal."""

    id = "<quoted literal>"
