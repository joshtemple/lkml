from lkml.tree import ContainerNode, DocumentNode, ListNode, PairNode, SyntaxToken
from pathlib import Path
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


def test_removing_item_from_list_serializes_sensibly():
    # Test with only whitespace in between items
    tree: ContainerNode = lkml.load("name: [a, b, c]")
    node: ListNode = tree.container.items[0]
    assert str(node) == "name: [a, b, c]"

    node.items = tuple(item for item in node.items if item.value != "b")
    assert str(node) == "name: [a, c]"

    node.items = tuple()
    assert str(node) == "name: []"

    # Test with leading and trailing spaces
    tree: ContainerNode = lkml.load("name: [ a, b, c ]")
    node: ListNode = tree.container.items[0]
    assert str(node) == "name: [ a, b, c ]"

    node.items = tuple(item for item in node.items if item.value != "b")
    assert str(node) == "name: [ a, c ]"

    node.items = tuple()
    assert str(node) == "name: []"

    # Test with items on new lines with trailing newline
    tree: DocumentNode = lkml.load("name: [\n  a,\n  b,\n  c\n]")
    node: ListNode = tree.container.items[0]
    assert str(node) == "name: [\n  a,\n  b,\n  c\n]"

    node.items = tuple(item for item in node.items if item.value != "b")
    assert str(node) == "name: [\n  a,\n  c\n]"

    node.items = tuple()
    assert str(node) == "name: []"


def test_modifying_key_does_not_change_serialized_whitespace():
    # Tests that the whitespace is defined by the colon token
    tree: DocumentNode = lkml.load("a :\n no")
    node: PairNode = tree.container.items[0]
    assert str(node) == "a :\n no"

    node.type = SyntaxToken("b")
    assert str(node) == "b :\n no"

    node.colon.prefix = ""
    assert str(node) == "b:\n no"


def test_view_with_all_fields():
    path = Path(__file__).parent / "resources" / "view_with_all_fields.view.lkml"
    with path.open() as file:
        raw = file.read()

    parsed = lkml.load(raw)
    assert parsed is not None

    # lookml = lkml.dump(parsed)
    # assert lookml.replace("\n\n", "\n") == raw.replace("\n\n", "\n")


def test_model_with_all_fields():
    path = Path(__file__).parent / "resources" / "model_with_all_fields.model.lkml"
    with path.open() as file:
        raw = file.read()

    parsed = lkml.load(raw)
    assert parsed is not None

    # lookml = lkml.dump(parsed)
    # assert lookml.replace("\n\n", "\n") == raw.replace("\n\n", "\n")


# def test_duplicate_top_level_keys():
#     parsed = load("duplicate_top_level_keys.view.lkml")
#     assert parsed is not None


# def test_duplicate_non_top_level_keys():
#     with pytest.raises(KeyError):
#         load("duplicate_non_top_level_keys.view.lkml")


# def test_reserved_dimension_names():
#     parsed = load("block_with_reserved_dimension_names.view.lkml")
#     assert parsed is not None
