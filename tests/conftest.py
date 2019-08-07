from pathlib import Path

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


@pytest.fixture
def lookml_path():
    path = Path(__file__).parent / "resources" / "view_with_all_fields.view.lkml"
    return str(path)


@pytest.fixture
def lexer():
    text = "Some sample text for testing."
    return lkml.Lexer(text)
