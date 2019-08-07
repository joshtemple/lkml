from pathlib import Path

import pytest

import lkml


def load(filename):
    """Helper method to load a LookML file from tests/resources and parse it."""
    path = Path(__file__).parent / "resources" / filename
    with path.open() as file:
        return lkml.load(file)


def test_block_with_single_quoted_field():
    lookml = load("block_with_single_quoted_field.view.lkml")
    assert lookml is not None


def test_block_with_multiple_quoted_fields():
    lookml = load("block_with_multiple_quoted_fields.view.lkml")
    assert lookml is not None


def test_block_with_nested_block():
    lookml = load("block_with_multiple_quoted_fields.view.lkml")
    assert lookml is not None


def test_view_with_all_fields():
    lookml = load("view_with_all_fields.view.lkml")
    assert lookml is not None


def test_model_with_all_fields():
    lookml = load("model_with_all_fields.model.lkml")
    assert lookml is not None


def test_duplicate_top_level_keys():
    lookml = load("duplicate_top_level_keys.view.lkml")
    assert lookml is not None


def test_duplicate_non_top_level_keys():
    with pytest.raises(KeyError):
        load("duplicate_non_top_level_keys.view.lkml")


def test_reserved_dimension_names():
    lookml = load("block_with_reserved_dimension_names.view.lkml")
    assert lookml is not None
