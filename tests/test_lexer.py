import pytest
import lkml
import lkml.tokens as tokens


@pytest.fixture
def lexer():
    text = "Some sample text for testing."
    return lkml.Lexer(text)


def test_peek_does_not_advance_index(lexer):
    index = lexer.index
    lexer.peek()
    assert lexer.index == index


def test_peek_default_returns_one_character(lexer):
    result = lexer.peek()
    assert len(result) == 1
    assert isinstance(result, str)


def test_peek_with_more_than_one_returns_correct_characters(lexer):
    result = lexer.peek(2)
    assert len(result) == 2
    result = lexer.peek(3)
    assert len(result) == 3


def test_advance_does_not_return_a_character(lexer):
    result = lexer.advance()
    assert result is None


def test_advance_increases_index_by_length(lexer):
    index = lexer.index
    lexer.advance()
    assert lexer.index == index + 1

    index = lexer.index
    lexer.advance(3)
    assert lexer.index == index + 3


def test_consume_advances_index_by_one(lexer):
    index = lexer.index
    lexer.consume()
    assert lexer.index == index + 1


def test_consume_returns_current_character(lexer):
    current_char = lexer.text[lexer.index]
    char = lexer.consume()
    assert char == current_char


def test_scan_until_token_skips_whitespace():
    text = "\n\t   \n  Start here"
    lexer = lkml.Lexer(text)
    lexer.scan_until_token()
    result = lexer.peek()
    assert result == "S"


def test_scan_until_token_skips_comments():
    text = "# This is a comment\nStart here"
    lexer = lkml.Lexer(text)
    lexer.scan_until_token()
    result = lexer.peek()
    assert result == "S"


params = [
    ("\0", tokens.StreamEndToken()),
    ("{", tokens.BlockStartToken()),
    ("}", tokens.BlockEndToken()),
    ("[", tokens.ListStartToken()),
    ("]", tokens.ListEndToken()),
    (",", tokens.CommaToken()),
    (":", tokens.ValueToken()),
    (";;", tokens.SqlBlockEndToken()),
]


@pytest.mark.parametrize("text,expected", params)
def test_scan_all_simple_tokens(text, expected):
    lexer = lkml.Lexer(text)
    result = lexer.scan()
    # Skip stream start token appended at the beginning
    assert result[1] == expected


def test_scan_quoted_literal():
    text = '"This is quoted text."'
    lexer = lkml.Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert token == tokens.QuotedLiteralToken("This is quoted text.")


def test_scan_quoted_literal_with_otherwise_illegal_chars():
    text = '"This: is {quoted} \n text."'
    lexer = lkml.Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert token == tokens.QuotedLiteralToken("This: is {quoted} \n text.")


def test_scan_literal():
    text = "unquoted_literal"
    token = lkml.Lexer(text).scan_literal()
    assert token == tokens.LiteralToken("unquoted_literal")


def test_scan_literal_with_following_whitespace():
    text = "unquoted_literal \n and text following whitespace"
    token = lkml.Lexer(text).scan_literal()
    assert token == tokens.LiteralToken("unquoted_literal")


def test_scan_sql_block_with_complex_sql_block():
    text = "concat(${orders.order_id}, '|', ${orders__items.primary_key}) ;;"
    token = lkml.Lexer(text).scan_sql_block()
    token == tokens.SqlBlockToken(
        "concat(${orders.order_id}, '|', ${orders__items.primary_key})"
    )


def test_scan_with_complex_sql_block():
    text = (
        "sql_distinct_key: concat(${orders.order_id}, '|', "
        "${orders__items.primary_key}) ;;"
    )
    output = lkml.Lexer(text).scan()
    assert output == (
        tokens.StreamStartToken(),
        tokens.LiteralToken("sql_distinct_key"),
        tokens.ValueToken(),
        tokens.SqlBlockToken(
            "concat(${orders.order_id}, '|', ${orders__items.primary_key})"
        ),
        tokens.SqlBlockEndToken(),
        tokens.StreamEndToken(),
    )
