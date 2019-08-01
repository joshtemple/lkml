import pytest
import lkml


@pytest.fixture
def serializer():
    return lkml.Serializer()


def test_serialize_dict_with_unquoted_literals(serializer):
    generator = serializer.serialize_dict(
        {"from_field": "field_name", "to_field": "field_name"}
    )
    result = "".join(generator)
    assert result == "".join(
        ("{\n", "  from_field: field_name\n", "  to_field: field_name\n", "}")
    )


def test_serialize_dict_with_quoted_literals(serializer):
    generator = serializer.serialize_dict(
        {
            "label": "Dimension Name",
            "group_label": "Group Name",
            "description": "A dimension description.",
        }
    )
    result = "".join(generator)
    assert result == "".join(
        (
            "{\n",
            '  label: "Dimension Name"\n',
            '  group_label: "Group Name"\n',
            '  description: "A dimension description."\n',
            "}",
        )
    )


def test_serialize_dict_with_name(serializer):
    generator = serializer.serialize_dict(
        {"name": "dimension_name", "label": "Dimension Name"}
    )
    result = "".join(generator)
    assert result == "".join(("dimension_name {\n", '  label: "Dimension Name"\n', "}"))
