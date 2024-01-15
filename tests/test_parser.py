from lkml.parser import Syntax
import pytest
import lkml
import lkml.tokens as tokens
from lkml.tokens import CommaToken, LiteralToken, ValueToken, WhitespaceToken
from lkml.tree import (
    Comma,
    LeftCurlyBrace,
    RightCurlyBrace,
    SyntaxToken,
    QuotedSyntaxToken,
    ExpressionSyntaxToken,
    Colon,
    LeftBracket,
    RightBracket,
    ListNode,
    PairNode,
    BlockNode,
    ContainerNode,
)


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
        tokens.ExpressionBlockToken("schema.table_name", 2),
        tokens.ExpressionBlockEndToken(2),
        tokens.LiteralToken("drill_fields", 3),
        tokens.ValueToken(3),
        tokens.ListStartToken(3),
        tokens.LiteralToken("view_name.field_one", 3),
        tokens.CommaToken(3),
        tokens.LiteralToken("view_name.field_two", 3),
        tokens.ListEndToken(3),
        tokens.BlockEndToken(4),
        tokens.StreamEndToken(4),
    )
    return lkml.parser.Parser(stream)


def test_tokens__repr__():
    token = tokens.ExpressionBlockToken("schema.table_name", 2)
    repr(token) == "ExpressionBlockToken(schema.table_name)"


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
        parser.consume_token_value()


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
    assert result == QuotedSyntaxToken(quoted_literal, 1)


def test_parse_value_literal():
    literal = "This is an unquoted literal."
    stream = (tokens.LiteralToken(literal, 1), tokens.StreamEndToken(1))
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result == SyntaxToken(literal, 1)


def test_parse_value_literal_with_sql_block():
    literal = "SELECT * FROM tablename"
    stream = (
        tokens.LiteralToken(literal, 1),
        tokens.ExpressionBlockEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result == SyntaxToken(literal, 1)


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
    assert result == QuotedSyntaxToken(quoted_literal, 1)
    assert parser.index == 1


def test_parse_value_without_closing_double_semicolons():
    stream = (
        tokens.ExpressionBlockToken("SELECT * FROM TABLE", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_value()
    assert result is None


def test_parse_key_normal_returns_token_value():
    stream = (tokens.LiteralToken("label", 1), tokens.ValueToken(1))
    parser = lkml.parser.Parser(stream)
    result = parser.parse_key()
    assert result == (SyntaxToken("label", 1), Colon(line_number=1))


def test_parse_key_without_literal_token():
    stream = (tokens.ValueToken(1), tokens.StreamEndToken(1))
    parser = lkml.parser.Parser(stream)
    result = parser.parse_key()
    assert result is None


def test_parse_key_without_value_token():
    stream = (tokens.LiteralToken("label", 1), tokens.StreamEndToken(1))
    parser = lkml.parser.Parser(stream)
    result = parser.parse_key()
    assert result is None


def test_parse_key_with_many_value_tokens():
    stream = (
        tokens.LiteralToken("label", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ValueToken(1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken("  ", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken("\t", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_key()
    assert result == (SyntaxToken("label", 1), Colon(line_number=1, suffix="\t"))


def test_debug_logging_statements_execute_successfully(parser):
    parser.log_debug = True
    parser.parse()


def test_parse_block_without_closing_curly_brace():
    stream = (
        tokens.LiteralToken("view", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.BlockStartToken(1),
        tokens.WhitespaceToken("\n", 1),
        tokens.LiteralToken("hidden", 2),
        tokens.ValueToken(2),
        tokens.WhitespaceToken(" ", 2),
        tokens.LiteralToken("yes", 2),
        tokens.StreamEndToken(3),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_block()
    assert result is None


def test_parse_nonmatching_container_raises_syntax_error():
    stream = (tokens.LiteralToken("view", 1), tokens.StreamEndToken(1))
    parser = lkml.parser.Parser(stream)
    with pytest.raises(SyntaxError):
        parser.parse_container()


def test_parse_pair_with_literal():
    stream = (
        tokens.LiteralToken("hidden", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("yes", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result == PairNode(
        type=SyntaxToken("hidden", 1),
        colon=Colon(line_number=1, suffix=" "),
        value=SyntaxToken("yes", 1),
    )


def test_parse_pair_with_quoted_literal():
    stream = (
        tokens.LiteralToken("view_label", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.QuotedLiteralToken("The View", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result == PairNode(
        type=SyntaxToken("view_label", 1),
        colon=Colon(line_number=1, suffix=" "),
        value=QuotedSyntaxToken("The View", 1),
    )
    with pytest.raises(AttributeError):
        result.prefix


def test_parse_pair_with_sql_block():
    sql = " SELECT * FROM schema.table "
    stream = (
        tokens.LiteralToken("sql", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ExpressionBlockToken(sql, 1),
        tokens.ExpressionBlockEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result == PairNode(
        type=SyntaxToken("sql", 1),
        colon=Colon(line_number=1, suffix=" "),
        value=ExpressionSyntaxToken(sql.strip(), 1),
    )


def test_parse_pair_with_bad_key():
    stream = (
        tokens.QuotedLiteralToken("hidden", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("yes", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_pair()
    assert result is None


def test_parse_pair_without_value_token():
    stream = (
        tokens.LiteralToken("hidden", 1),
        tokens.WhitespaceToken(" ", 1),
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
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("view_name.field_two", 1),
        tokens.CommaToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("view_name.field_three", 1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(
            SyntaxToken("view_name.field_one", 1),
            SyntaxToken("view_name.field_two", 1, prefix=" "),
            SyntaxToken("view_name.field_three", 1, prefix=" "),
        ),
        right_bracket=RightBracket(),
    )


def test_parse_list_with_pairs():
    stream = (
        tokens.LiteralToken("sorts", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("orders.customer_id", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("asc", 1),
        tokens.CommaToken(1),
        tokens.LiteralToken("orders.order_id", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("desc", 1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("sorts", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(
            PairNode(
                type=SyntaxToken("orders.customer_id", 1),
                colon=Colon(line_number=1, suffix=" "),
                value=SyntaxToken("asc", 1),
            ),
            PairNode(
                type=SyntaxToken("orders.order_id", 1),
                colon=Colon(line_number=1, suffix=" "),
                value=SyntaxToken("desc", 1),
            ),
        ),
        right_bracket=RightBracket(),
    )

    stream = (
        tokens.LiteralToken("filters", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.WhitespaceToken("\n  ", 1),
        tokens.LiteralToken("view_name.field_one", 2),
        tokens.ValueToken(2),
        tokens.WhitespaceToken(" ", 2),
        tokens.QuotedLiteralToken("-0,-1,-8,-9,-99,-NULL,-EMPTY", 2),
        tokens.WhitespaceToken("\n", 2),
        tokens.ListEndToken(3),
        tokens.StreamEndToken(3),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("filters", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(
            PairNode(
                type=SyntaxToken("view_name.field_one", 2, prefix="\n  "),
                colon=Colon(line_number=2, suffix=" "),
                value=QuotedSyntaxToken("-0,-1,-8,-9,-99,-NULL,-EMPTY", 2, suffix="\n"),
            ),
        ),
        right_bracket=RightBracket(),
    )


def test_parse_list_with_trailing_comma():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(SyntaxToken("view_name.field_one", 1),),
        trailing_comma=Comma(),
        right_bracket=RightBracket(),
    )

    # Test when the list items are separated by newlines
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.WhitespaceToken("\n  ", 1),
        tokens.LiteralToken("view_name.field_one", 2),
        tokens.CommaToken(2),
        tokens.WhitespaceToken("\n", 2),
        tokens.ListEndToken(3),
        tokens.StreamEndToken(3),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(SyntaxToken("view_name.field_one", 2, prefix="\n  "),),
        trailing_comma=Comma(),
        right_bracket=RightBracket(prefix="\n"),
    )


def test_parse_list_with_leading_comma():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.CommaToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(SyntaxToken("view_name.field_one", 1),),
        right_bracket=RightBracket(),
        leading_comma=Comma(),
    )


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
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=tuple(),
        right_bracket=RightBracket(),
    )

    # Add whitespace between brackets
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=tuple(),
        right_bracket=RightBracket(prefix=" "),
    )


def test_parse_list_with_no_opening_bracket():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.LiteralToken("view_name.field_two", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result is None


def test_parse_list_with_bad_token():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.LiteralToken("view_name.field_two", 1),
        tokens.CommaToken(1),
        tokens.ValueToken(1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result is None


def test_parse_list_with_only_commas():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.ListStartToken(1),
        tokens.CommaToken(1),
        tokens.CommaToken(1),
        tokens.CommaToken(1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result is None


def test_parse_list_with_trailing_comment():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.LiteralToken("view_name.field_one", 1),
        tokens.CommaToken(1),
        tokens.LiteralToken("view_name.field_two", 1),
        tokens.ListEndToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.CommentToken("# This is a comment", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(
            SyntaxToken("view_name.field_one", 1),
            SyntaxToken("view_name.field_two", 1),
        ),
        right_bracket=RightBracket(suffix=" # This is a comment"),
    )


def test_parse_list_with_inner_comment():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.WhitespaceToken("\n  ", 1),
        tokens.LiteralToken("view_name.field_one", 2),
        tokens.CommaToken(2),
        tokens.WhitespaceToken("\n  ", 2),
        tokens.LiteralToken("view_name.field_two", 3),
        tokens.WhitespaceToken(" ", 3),
        tokens.CommentToken("# This is a comment", 3),
        tokens.WhitespaceToken("\n", 3),
        tokens.ListEndToken(4),
        tokens.StreamEndToken(4),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(
            SyntaxToken("view_name.field_one", 2, prefix="\n  "),
            SyntaxToken(
                "view_name.field_two", 3, prefix="\n  ", suffix=" # This is a comment\n"
            ),
        ),
        right_bracket=RightBracket(),
    )


def test_parse_list_with_only_comment():
    stream = (
        tokens.LiteralToken("drill_fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.WhitespaceToken("\n  ", 1),
        tokens.CommentToken("# Put some fields here", 2),
        tokens.WhitespaceToken("\n", 2),
        tokens.ListEndToken(3),
        tokens.StreamEndToken(3),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("drill_fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=tuple(),
        right_bracket=RightBracket(prefix="\n  # Put some fields here\n"),
    )


def test_parse_list_with_space_delimited_hyphen():
    stream = (
        tokens.LiteralToken("fields", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.ListStartToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("-", 1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("view.dimension_name", 1),
        tokens.ListEndToken(1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_list()
    assert result == ListNode(
        type=SyntaxToken("fields", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_bracket=LeftBracket(),
        items=(SyntaxToken("-view.dimension_name", 1, prefix=" "),),
        right_bracket=RightBracket(),
    )


def test_parse_block_with_no_expression():
    stream = (
        tokens.LiteralToken("dimension", 1),
        tokens.ValueToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.LiteralToken("dimension_name", 1),
        tokens.WhitespaceToken(" ", 1),
        tokens.BlockStartToken(1),
        tokens.BlockEndToken(1),
        tokens.WhitespaceToken(" ", 1),
        tokens.StreamEndToken(1),
    )
    parser = lkml.parser.Parser(stream)
    result = parser.parse_block()
    assert result == BlockNode(
        type=SyntaxToken("dimension", 1),
        name=SyntaxToken("dimension_name", 1),
        colon=Colon(line_number=1, suffix=" "),
        left_brace=LeftCurlyBrace(prefix=" "),
        container=ContainerNode(items=tuple()),
        right_brace=RightCurlyBrace(),
    )
