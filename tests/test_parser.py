import pytest
import lkml
import lkml.tokens as tokens


@pytest.fixture
def parser():
    stream = [
        tokens.StreamStartToken(),
        tokens.LiteralToken("view"),
        tokens.ValueToken(),
        tokens.LiteralToken("view_name"),
        tokens.BlockStartToken(),
        tokens.LiteralToken("sql_table_name"),
        tokens.ValueToken(),
        tokens.LiteralToken("schema.table_name"),
        tokens.SqlEndToken(),
        tokens.BlockEndToken(),
        tokens.StreamEndToken(),
    ]
    return lkml.parser.Parser(stream)


def test_init_parser_index_starts_at_zero(parser):
    assert parser.index == 0


def test_init_parser_has_tokens(parser):
    assert len(parser.tokens) > 0


def test_init_all_tokens_must_be_tokens():
    with pytest.raises(TypeError):
        lkml.parser.Parser(["a", "b", "c", "d", 1, 2, 3, 4])


def test_peek_does_not_advance_index(parser):
    index = parser.index
    parser.peek()
    assert parser.index == index


def test_peek_default_returns_one_token(parser):
    result = parser.peek()
    assert isinstance(result, tokens.Token)


def test_peek_length_greater_than_one_returns_list_of_tokens(parser):
    result = parser.peek(2)
    assert isinstance(result, list)
    assert all(isinstance(token, tokens.Token) for token in result)
    assert len(result) == 2

    result = parser.peek(5)
    assert isinstance(result, list)
    assert all(isinstance(token, tokens.Token) for token in result)
    assert len(result) == 5


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
