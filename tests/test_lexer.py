import lkml
import lkml.tokens as tokens


def test_scan_quoted_literal():
    text = '"This is quoted text."'
    lexer = lkml.Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert token.value == "This is quoted text."


def test_scan_quoted_literal_with_otherwise_illegal_chars():
    text = '"This: is {quoted} \n text."'
    lexer = lkml.Lexer(text)
    lexer.index = 1
    token = lexer.scan_quoted_literal()
    assert isinstance(token, tokens.QuotedLiteralToken)
    assert token.value == "This: is {quoted} \n text."


def test_scan_literal():
    text = "unquoted_literal"
    token = lkml.Lexer(text).scan_literal()
    assert isinstance(token, tokens.LiteralToken)
    assert token.value == "unquoted_literal"


def test_scan_literal_with_following_whitespace():
    text = "unquoted_literal \n and text following whitespace"
    token = lkml.Lexer(text).scan_literal()
    assert isinstance(token, tokens.LiteralToken)
    assert token.value == "unquoted_literal"


def test_scan_sql_block_with_complex_sql_block():
    text = "concat(${orders.order_id}, '|', ${orders__items.primary_key}) ;;"
    token = lkml.Lexer(text).scan_sql_block()
    assert (
        token.value == "concat(${orders.order_id}, '|', ${orders__items.primary_key})"
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
