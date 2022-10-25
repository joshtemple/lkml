from dataclasses import replace
from lkml.tree import ContainerNode, DocumentNode, ListNode
from pathlib import Path
import pytest
import lkml


def load(filename):
    """Helper method to load a LookML file from tests/resources and parse it."""
    path = Path(__file__).parent / "resources" / filename
    with path.open() as file:
        text = file.read()
    return lkml.parse(text)


def test_block_with_single_quoted_field():
    parsed = load("block_with_single_quoted_field.view.lkml")
    assert parsed is not None


def test_block_with_multiple_quoted_fields():
    parsed = load("block_with_multiple_quoted_fields.view.lkml")
    assert parsed is not None


def test_block_with_nested_block():
    parsed = load("block_with_multiple_quoted_fields.view.lkml")
    assert parsed is not None


def test_removing_item_from_list_serializes_sensibly():
    # Test with only whitespace in between items
    tree: ContainerNode = lkml.parse("name: [a, b, c]")
    node: ListNode = tree.container.items[0]
    assert str(node) == "name: [a, b, c]"

    new_items = tuple(item for item in node.items if item.value != "b")
    node = replace(node, items=new_items)
    assert str(node) == "name: [a, c]"

    node = replace(node, items=tuple())
    assert str(node) == "name: []"

    # Test with leading and trailing spaces
    tree: ContainerNode = lkml.parse("name: [ a, b, c ]")
    node: ListNode = tree.container.items[0]
    assert str(node) == "name: [ a, b, c ]"

    new_items = tuple(item for item in node.items if item.value != "b")
    node = replace(node, items=new_items)
    assert str(node) == "name: [ a, c ]"

    node = replace(node, items=tuple())
    assert str(node) == "name: []"

    # Test with items on new lines with trailing newline
    tree: DocumentNode = lkml.parse("name: [\n  a,\n  b,\n  c\n]")
    node: ListNode = tree.container.items[0]
    assert str(node) == "name: [\n  a,\n  b,\n  c\n]"

    new_items = tuple(item for item in node.items if item.value != "b")
    node = replace(node, items=new_items)
    assert str(node) == "name: [\n  a,\n  c\n]"

    node = replace(node, items=tuple())
    assert str(node) == "name: []"


def test_view_with_all_fields():
    path = Path(__file__).parent / "resources" / "view_with_all_fields.view.lkml"
    with path.open() as file:
        raw = file.read()

    parsed = lkml.load(raw)
    assert parsed is not None


def test_model_with_all_fields():
    path = Path(__file__).parent / "resources" / "model_with_all_fields.model.lkml"
    with path.open() as file:
        raw = file.read()

    parsed = lkml.load(raw)
    assert parsed is not None


def test_duplicate_top_level_keys():
    parsed = load("duplicate_top_level_keys.view.lkml")
    assert parsed is not None


def test_duplicate_non_top_level_keys():
    with pytest.raises(KeyError):
        load("duplicate_non_top_level_keys.view.lkml")


def test_lists_with_comma_configurations():
    parsed = load("lists_with_comma_configurations.view.lkml")
    assert parsed is not None


def test_reserved_dimension_names():
    parsed = load("block_with_reserved_dimension_names.view.lkml")
    assert parsed is not None


def test_repeated_dump_does_not_mutate_input():
    text = """view: albums {
        dimension: id {
            primary_key: yes
            type: number
            sql: ${TABLE}.album_id ;;
        }
    }
    """

    tree = lkml.parse(text)
    visitor = lkml.DictVisitor()
    parsed: dict = visitor.visit(tree)
    first = lkml.dump(parsed)
    second = lkml.dump(parsed)
    assert first == second
