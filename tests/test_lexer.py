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


def test_peek_multiple_with_more_than_one_returns_correct_characters(lexer):
    result = lexer.peek_multiple(2)
    assert len(result) == 2
    result = lexer.peek_multiple(3)
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
    ("\0", tokens.StreamEndToken(1)),
    ("{", tokens.BlockStartToken(1)),
    ("}", tokens.BlockEndToken(1)),
    ("[", tokens.ListStartToken(1)),
    ("]", tokens.ListEndToken(1)),
    (",", tokens.CommaToken(1)),
    (":", tokens.ValueToken(1)),
    (";;", tokens.ExpressionBlockEndToken(1)),
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
    assert token == tokens.QuotedLiteralToken("This is quoted text.", 1)


def test_scan_quoted_literal_with_otherwise_illegal_chars():
    text = '"This: is {quoted} \n text."'
    lexer = lkml.Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert token == tokens.QuotedLiteralToken("This: is {quoted} \n text.", 1)


def test_scan_quoted_literal_with_escaped_quotes():
    text = r'"#.### \"M\""'
    lexer = lkml.Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert token == tokens.QuotedLiteralToken(r"#.### \"M\"", 1)


def test_scan_literal():
    text = "unquoted_literal"
    token = lkml.Lexer(text).scan_literal()
    assert token == tokens.LiteralToken("unquoted_literal", 1)


def test_scan_literal_with_following_whitespace():
    text = "unquoted_literal \n and text following whitespace"
    token = lkml.Lexer(text).scan_literal()
    assert token == tokens.LiteralToken("unquoted_literal", 1)


def test_scan_expression_block_with_complex_sql_block():
    text = "concat(${orders.order_id}, '|',\n${orders__items.primary_key}) ;;"
    token = lkml.Lexer(text).scan_expression_block()
    token == tokens.ExpressionBlockToken(
        "concat(${orders.order_id}, '|', ${orders__items.primary_key})", 1
    )


def test_scan_with_complex_sql_block():
    text = (
        "sql_distinct_key: concat(${orders.order_id}, '|', "
        "${orders__items.primary_key}) ;;"
    )
    output = lkml.Lexer(text).scan()
    assert output == (
        tokens.StreamStartToken(1),
        tokens.LiteralToken("sql_distinct_key", 1),
        tokens.ValueToken(1),
        tokens.ExpressionBlockToken(
            "concat(${orders.order_id}, '|', ${orders__items.primary_key})", 1
        ),
        tokens.ExpressionBlockEndToken(1),
        tokens.StreamEndToken(1),
    )


def test_scan_with_non_expression_block_starting_with_sql():
    text = "sql_not_reserved_field: yes"
    output = lkml.Lexer(text).scan()
    assert output == (
        tokens.StreamStartToken(1),
        tokens.LiteralToken("sql_not_reserved_field", 1),
        tokens.ValueToken(1),
        tokens.LiteralToken("yes", 1),
        tokens.StreamEndToken(1),
    )


def test_scan_with_non_expression_block_starting_with_html():
    text = "html_not_reserved_field: yes"
    output = lkml.Lexer(text).scan()
    assert output == (
        tokens.StreamStartToken(1),
        tokens.LiteralToken("html_not_reserved_field", 1),
        tokens.ValueToken(1),
        tokens.LiteralToken("yes", 1),
        tokens.StreamEndToken(1),
    )
