from lkml.lexer import Lexer
import lkml.tokens as tokens


def test_scan_quoted_literal():
    text = '"This is quoted text."'
    lexer = Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert token.value == "This is quoted text."


def test_scan_quoted_literal_with_otherwise_illegal_chars():
    text = '"This: is {quoted} \n text."'
    lexer = Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert isinstance(token, tokens.QuotedLiteralToken)
    assert token.value == "This: is {quoted} \n text."


def test_scan_literal():
    text = "unquoted_literal"
    token = Lexer(text).scan_literal()
    assert isinstance(token, tokens.LiteralToken)
    assert token.value == "unquoted_literal"


def test_scan_literal_with_following_whitespace():
    text = "unquoted_literal \n and text following whitespace"
    token = Lexer(text).scan_literal()
    assert isinstance(token, tokens.LiteralToken)
    assert token.value == "unquoted_literal"
