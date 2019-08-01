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


def test_serialize_nested_dict(serializer):
    generator = serializer.serialize_dict(
        {
            "derived_table": {
                "explore_source": {
                    "bind_filters": {
                        "from_field": "field_name",
                        "to_field": "field_name",
                    },
                    "name": "explore_name",
                }
            }
        }
    )
    result = "".join(generator)

    assert result == "".join(
        (
            "{\n",
            "  derived_table: {\n",
            "    explore_source: explore_name {\n",
            "      bind_filters: {\n",
            "        from_field: field_name\n",
            "        to_field: field_name\n",
            "      }\n",
            "    }\n",
            "  }\n",
            "}",
        )
    )


def test_serialize_empty_dict_with_name(serializer):
    generator = serializer.serialize_dict({"name": "dimension_name"})
    result = "".join(generator)
    assert result == "dimension_name {}"


def test_serialize_empty_dict_without_name(serializer):
    generator = serializer.serialize_dict({})
    result = "".join(generator)
    assert result == "{}"


def test_serialize_list_with_unquoted_literals(serializer):
    generator = serializer.serialize_list(
        ["dimension_one", "dimension_two", "dimension_three"], key="fields"
    )
    result = "".join(generator)
    assert result == "[dimension_one, dimension_two, dimension_three]"


def test_serialize_list_with_quoted_literals(serializer):
    generator = serializer.serialize_list(
        ["column_one", "column_two", "column_three"], key="sortkeys"
    )
    result = "".join(generator)
    assert result == '["column_one", "column_two", "column_three"]'


def test_serialize_with_plural_key(serializer):
    generator = serializer.serialize(
        {"dimensions": [{"name": "dimension_one"}, {"name": "dimension_two"}]}
    )
    result = "".join(generator)
    print(result)
    assert result == "dimension: dimension_one {}\n\ndimension: dimension_two {}"


def test_serialize_view_with_multiple_dimensions(serializer):
    generator = serializer.serialize(
        {
            "views": [
                {
                    "sql_table_name": "schema.table_name",
                    "dimensions": [
                        {
                            "type": "string",
                            "sql": "${TABLE}.a_dimension",
                            "name": "a_dimension",
                        },
                        {
                            "type": "number",
                            "sql": "${TABLE}.another_dimension",
                            "name": "another_dimension",
                        },
                        {
                            "type": "yesno",
                            "sql": "${TABLE}.yet_another_dimension",
                            "name": "yet_another_dimension",
                        },
                    ],
                    "dimension_groups": [
                        {
                            "type": "time",
                            "timeframes": [
                                "raw",
                                "time",
                                "hour_of_day",
                                "date",
                                "day_of_week",
                                "week",
                                "month",
                                "quarter",
                                "year",
                            ],
                            "sql": "${TABLE}.a_dimension_group",
                            "name": "a_dimension_group",
                        }
                    ],
                    "name": "view_name",
                }
            ]
        }
    )
    result = "".join(generator)
    print(result)
    assert False
