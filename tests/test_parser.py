import logging
from pathlib import Path
import lkml


def load(filename):
    """Helper method to load a LookML file from tests/resources and parse it."""
    path = Path(__file__).parent / "resources" / filename
    parsed = lkml.load(path)
    return parsed


def test_block_with_single_quoted_field():
    parsed = load("block_with_single_quoted_field.view.lkml")
    assert parsed


def test_block_with_multiple_quoted_fields():
    parsed = load("block_with_multiple_quoted_fields.view.lkml")
    assert parsed
