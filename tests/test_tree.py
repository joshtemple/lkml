import pytest
from lkml.tree import (
    BlockNode,
    ContainerNode,
    LeftBracket,
    LeftCurlyBrace,
    ListNode,
    PairNode,
    RightBracket,
    RightCurlyBrace,
    SyntaxToken,
    QuotedSyntaxToken,
    ExpressionSyntaxToken,
)
from lkml.visitors import LookMlVisitor


@pytest.mark.parametrize(
    "token_class,expected", [(SyntaxToken, "foo"), (QuotedSyntaxToken, '"foo"')]
)
def test_syntax_token_str_should_return_formatted(token_class, expected):
    assert str(token_class("foo")) == expected


def test_quoted_syntax_token_quotes_double_quotes():
    text = 'This is the "best" dimension'
    token = QuotedSyntaxToken(text)
    assert token.format_value() == r'"This is the \"best\" dimension"'


def test_expression_syntax_token_with_expression_suffix():
    sql = "SELECT * FROM orders"
    token = ExpressionSyntaxToken(
        sql, prefix=" ", suffix=" # A comment", expr_suffix=" "
    )
    assert str(token) == " SELECT * FROM orders ;; # A comment"


def test_pair_node_str_should_return_formatted():
    node = PairNode(type=SyntaxToken("foo"), value=SyntaxToken("bar"))
    assert str(node) == "foo: bar"

    # Add whitespace in an unconventional place
    node = PairNode(type=SyntaxToken("foo", suffix=" "), value=SyntaxToken("bar"))
    assert str(node) == "foo : bar"


def test_pair_node_should_not_have_children():
    node = PairNode(type=SyntaxToken("foo"), value=SyntaxToken("bar"))
    assert node.children is None


def test_list_node_str_should_return_formatted():
    # Test a node with PairNodes as items
    node = ListNode(
        type=SyntaxToken("filters"),
        left_bracket=LeftBracket(),
        items=(
            PairNode(SyntaxToken("created_date"), QuotedSyntaxToken("7 days")),
            PairNode(
                SyntaxToken("user.status", prefix=" "), QuotedSyntaxToken("-disabled")
            ),
        ),
        right_bracket=RightBracket(),
    )
    assert str(node) == 'filters: [created_date: "7 days", user.status: "-disabled"]'

    # Test a node with SyntaxTokens as items
    node = ListNode(
        type=SyntaxToken("fields"),
        left_bracket=LeftBracket(),
        items=(
            SyntaxToken("user.user_id", prefix="\n  "),
            SyntaxToken("user.age", prefix="\n  ", suffix="\n"),
        ),
        right_bracket=RightBracket(),
    )
    assert str(node) == "fields: [\n  user.user_id,\n  user.age\n]"

    # Test a node with zero items
    node = ListNode(
        type=SyntaxToken("fields"),
        left_bracket=LeftBracket(),
        items=tuple(),
        right_bracket=RightBracket(),
    )
    assert str(node) == "fields: []"


def test_block_node_str_should_return_formatted():
    # Test a regular block
    node = BlockNode(
        type=SyntaxToken("set"),
        name=SyntaxToken("user_dimensions"),
        left_brace=LeftCurlyBrace(prefix=" ", suffix=" "),
        container=ContainerNode(
            (
                ListNode(
                    type=SyntaxToken("fields"),
                    left_bracket=LeftBracket(),
                    items=(
                        SyntaxToken("user.user_id"),
                        SyntaxToken("user.age", prefix=" "),
                    ),
                    right_bracket=RightBracket(),
                ),
            )
        ),
        right_brace=RightCurlyBrace(prefix=" "),
    )
    assert str(node) == "set: user_dimensions { fields: [user.user_id, user.age] }"

    # Test a block with no expression
    node = BlockNode(
        type=SyntaxToken("set"),
        name=SyntaxToken("foo"),
        left_brace=LeftCurlyBrace(prefix=" "),
        container=tuple(),
        right_brace=RightCurlyBrace(),
    )
    assert str(node) == "set: foo {}"


def test_container_node_str_should_return_formatted():
    node = ContainerNode(
        (
            PairNode(SyntaxToken("hidden"), SyntaxToken("true")),
            BlockNode(
                type=SyntaxToken("set", prefix=" "),
                name=SyntaxToken("foo"),
                left_brace=LeftCurlyBrace(prefix=" "),
                container=tuple(),
                right_brace=RightCurlyBrace(),
            ),
            ListNode(
                type=SyntaxToken("fields", prefix=" "),
                left_bracket=LeftBracket(),
                items=tuple(),
                right_bracket=RightBracket(),
            ),
        )
    )
    assert str(node) == "hidden: true set: foo {} fields: []"


def syntax_token_with_trivia_str_should_render():
    token = SyntaxToken("foo", prefix="# Skip this\n  ")
    assert str(token) == "# Skip this\n  foo"

    token = SyntaxToken("foo", suffix="\n# Skip this\n  ")
    assert str(token == "foo\n# Skip this\n  ")

    token = SyntaxToken("foo", prefix="\n\t", suffix="\t\n")
    assert str(token) == "\n\tfoo\t\n"


def test_lookml_visitor_should_visit_syntax_token_correctly():
    visitor = LookMlVisitor()
    token = SyntaxToken("foo", suffix="\n")
    assert visitor.visit_token(token) == "foo\n"
