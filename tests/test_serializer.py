import pytest
import lkml


@pytest.fixture
def serializer():
    return lkml.Serializer()


def test_serialize_dict_with_unquoted_literals(serializer):
    generator = serializer.serialize_dict(
        {"name": "bind_filters", "from_field": "field_name", "to_field": "field_name"}
    )
    result = "".join(generator)
    assert result == "".join(
        (
            "bind_filters: {\n",
            "  from_field: field_name\n",
            "  to_field: field_name\n",
            "}",
        )
    )


def test_serialize_dict_with_quoted_literals(serializer):
    generator = serializer.serialize_dict(
        {
            "name": "dimension",
            "label": "Dimension Name",
            "group_label": "Group Name",
            "description": "A dimension description.",
        }
    )
    result = "".join(generator)
    assert result == "".join(
        (
            "dimension: {\n",
            '  label: "Dimension Name"\n',
            '  group_label: "Group Name"\n',
            '  description: "A dimension description."\n',
            "}",
        )
    )


def test_serialize_dict_with_no_name(serializer):
    with pytest.raises(KeyError):
        generator = serializer.serialize_dict({"label": "Dimension Name"})
        result = "".join(generator)
