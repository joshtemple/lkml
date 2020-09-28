from pathlib import Path

import pytest

import lkml


def load(filename):
    """Helper method to load a LookML file from tests/resources and parse it."""
    path = Path(__file__).parent / "resources" / filename
    with path.open() as file:
        return lkml.load(file)


def test_block_with_single_quoted_field():
    parsed = load("block_with_single_quoted_field.view.lkml")
    assert parsed is not None


def test_block_with_multiple_quoted_fields():
    parsed = load("block_with_multiple_quoted_fields.view.lkml")
    assert parsed is not None


def test_block_with_nested_block():
    parsed = load("block_with_multiple_quoted_fields.view.lkml")
    assert parsed is not None


def test_view_with_all_fields():
    path = Path(__file__).parent / "resources" / "view_with_all_fields.view.lkml"
    with path.open() as file:
        raw = file.read()

    parsed = lkml.load(raw)
    assert parsed is not None

    lookml = lkml.dump(parsed)
    assert lookml.replace("\n\n", "\n") == raw.replace("\n\n", "\n")


def test_model_with_all_fields():
    path = Path(__file__).parent / "resources" / "model_with_all_fields.model.lkml"
    with path.open() as file:
        raw = file.read()

    parsed = lkml.load(raw)
    assert parsed is not None

    lookml = lkml.dump(parsed)
    assert lookml.replace("\n\n", "\n") == raw.replace("\n\n", "\n")


def test_duplicate_top_level_keys():
    parsed = load("duplicate_top_level_keys.view.lkml")
    assert parsed is not None


def test_duplicate_non_top_level_keys():
    with pytest.raises(KeyError):
        load("duplicate_non_top_level_keys.view.lkml")


def test_reserved_dimension_names():
    parsed = load("block_with_reserved_dimension_names.view.lkml")
    assert parsed is not None


def test_view_with_refinements():
    parsed = load("view_with_refinements.view.lkml")
    assert parsed is not None


def test_measure_with_new_filters_syntax():
    parsed = load("measure_with_new_filters_syntax.view.lkml")
    assert parsed is not None


def test_kitchen_sink():
    parsed = load("kitchensink.model.lkml")
    assert parsed is not None
