import pytest
from pathlib import Path
import lkml


def load(filename,  allow_dupe_model_keys=False):
    """Helper method to load a LookML file from tests/resources and parse it."""
    path = Path(__file__).parent / "resources" / filename
    with path.open() as file:
        return lkml.load(file, allow_dupe_model_keys)


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


def test_model_with_dupe_fields():
   with pytest.raises(Exception) as e:
       lookml = load("model_with_dupe_field.model.lkml")
   assert 'Key "week_start_day" already exists in tree and would overwrite the existing value' in str(e.value)

def test_model_with_dupe_fields2():
   lookml = load("model_with_dupe_field.model.lkml", allow_dupe_model_keys=True)
