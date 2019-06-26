from typing import Sequence
import pytest
import lkml
import lkml.tokens as tokens


@pytest.fixture
def parser():
    stream = (
        tokens.StreamStartToken(1),
        tokens.LiteralToken("view", 1),
        tokens.ValueToken(1),
        tokens.LiteralToken("view_name", 1),
        tokens.BlockStartToken(1),
        tokens.LiteralToken("sql_table_name", 2),
        tokens.ValueToken(2),
        tokens.LiteralToken("schema.table_name", 2),
        tokens.ExpressionBlockEndToken(2),
        tokens.BlockEndToken(3),
        tokens.StreamEndToken(3),
    )
    return lkml.parser.Parser(stream)


def test_init_parser_index_starts_at_zero(parser):
    assert parser.index == 0


def test_init_parser_has_tokens(parser):
    assert len(parser.tokens) > 0


def test_init_all_tokens_must_be_tokens():
    with pytest.raises(TypeError):
        lkml.parser.Parser(("a", "b", "c", "d", 1, 2, 3, 4))


def test_peek_does_not_advance_index(parser):
    index = parser.index
    parser.peek()
    assert parser.index == index


def test_peek_default_returns_one_token(parser):
    result = parser.peek()
    assert isinstance(result, tokens.Token)


def test_advance_does_not_return_a_token(parser):
    result = parser.advance()
    assert result is None


def test_advance_increases_index_by_length(parser):
    index = parser.index
    parser.advance()
    assert parser.index == index + 1

    index = parser.index
    parser.advance(3)
    assert parser.index == index + 3


def test_consume_advances_index_by_one(parser):
    index = parser.index
    parser.consume()
    assert parser.index == index + 1


def test_consume_returns_current_token(parser):
    current_token = parser.tokens[parser.index]
    token = parser.consume()
    assert token == current_token


def test_consume_token_value_does_not_return_token(parser):
    parser.index = 1
    result = parser.consume_token_value()
    assert not isinstance(result, tokens.Token)
    assert result == "view"


def test_consume_token_value_raises_error_if_not_found(parser):
    with pytest.raises(AttributeError):
        result = parser.consume_token_value()


def test_check_returns_true_for_single_valid_type(parser):
    assert parser.check(tokens.StreamStartToken)


def test_check_returns_false_for_single_invalid_type(parser):
    assert not parser.check(tokens.ValueToken)


def test_check_returns_true_for_mix_of_valid_and_invalid_types(parser):
    assert parser.check(tokens.ValueToken, tokens.StreamStartToken)


def test_check_returns_false_for_all_invalid_types(parser):
    assert not parser.check(tokens.ValueToken, tokens.QuotedLiteralToken)


def test_check_raises_if_token_types_arg_is_not_a_token(parser):
    with pytest.raises(TypeError):
        parser.check(str)


def test_parse_value_quoted_literal():
    quoted_literal = "This is a quoted literal."
    stream = (tokens.QuotedLiteralToken(quoted_literal, 1), tokens.StreamEndToken(1))
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result == quoted_literal


def test_parse_value_literal():
    literal = "This is an unquoted literal."
    stream = (tokens.LiteralToken(literal, 1), tokens.StreamEndToken(1))
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result == literal


def test_parse_value_literal_with_sql_block():
    literal = "SELECT * FROM tablename"
    stream = (
        tokens.LiteralToken(literal, 1),
        tokens.ExpressionBlockEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result == literal


def test_parse_value_invalid_tokens():
    stream = (tokens.ValueToken(1), tokens.StreamEndToken(1))
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result is None


def test_parse_value_quoted_literal_with_leftovers():
    quoted_literal = "This is a quoted literal."
    literal = "Some other tokens following."
    stream = (
        tokens.QuotedLiteralToken(quoted_literal, 1),
        tokens.LiteralToken(literal, 1),
        tokens.ValueToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result == quoted_literal
    assert parser.index == 1


def test_parse_pair_with_literal():
    stream = (
        tokens.LiteralToken("hidden", 1),
        tokens.ValueToken(1),
        tokens.LiteralToken("yes", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result == {"hidden": "yes"}


def test_parse_pair_with_quoted_literal():
    stream = (
        tokens.LiteralToken("view_label", 1),
        tokens.ValueToken(1),
        tokens.QuotedLiteralToken("View Label", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result == {"view_label": "View Label"}


def test_parse_pair_with_sql_block():
    sql = "SELECT * FROM schema.table"
    stream = (
        tokens.LiteralToken("sql", 1),
        tokens.ValueToken(1),
        tokens.LiteralToken(sql, 1),
        tokens.ExpressionBlockEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result == {"sql": sql}


def test_parse_pair_with_bad_key():
    stream = (
        tokens.QuotedLiteralToken("hidden", 1),
        tokens.ValueToken(1),
        tokens.LiteralToken("yes", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result is None


def test_parse_pair_without_value_token():
    stream = (
        tokens.LiteralToken("hidden", 1),
        tokens.LiteralToken("yes", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result is None


def test_parse_list_with_literals():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.LiteralToken("view_name.field_two", 1),
        tokens.CommaToken(1),
        tokens.LiteralToken("view_name.field_three", 1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == {
        "drill_fields": [
            "view_name.field_one",
            "view_name.field_two",
            "view_name.field_three",
        ]
    }


def test_parse_list_with_trailing_comma():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result is None


def test_parse_list_with_missing_comma():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.LiteralToken("view_name.field_two", 1),
        tokens.LiteralToken("view_name.field_three", 1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result is None


def test_parse_list_with_no_contents():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.ListStartToken(1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == {"drill_fields": []}


def test_parse_block_with_no_expression():
    stream = (
        tokens.LiteralToken("dimension", 1),
        tokens.ValueToken(1),
        tokens.LiteralToken("dimension_name", 1),
        tokens.BlockStartToken(1),
        tokens.BlockEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_block()
    assert result == {"dimension": {"name": "dimension_name"}}
