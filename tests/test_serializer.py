import pytest
import lkml


@pytest.fixture
def serializer():
    return lkml.Serializer()


def test_write_value_with_unquoted_literal(serializer):
    generator = serializer.write_value(key="hidden", value="no")
    result = "".join(generator)
    print(result)
    assert result == "no"


def test_write_value_with_quoted_literal(serializer):
    generator = serializer.write_value(key="label", value="Dimension Name")
    result = "".join(generator)
    print(result)
    assert result == '"Dimension Name"'


def test_write_key(serializer):
    generator = serializer.write_key(key="hidden")
    result = "".join(generator)
    print(result)
    assert result == "hidden: "


def test_write_pair_with_unquoted_literal(serializer):
    generator = serializer.write_pair(key="hidden", value="no")
    result = "".join(generator)
    print(result)
    assert result == "hidden: no"


def test_write_pair_with_quoted_literal(serializer):
    generator = serializer.write_pair(key="label", value="Dimension Name")
    result = "".join(generator)
    print(result)
    assert result == 'label: "Dimension Name"'


def test_write_set_with_unquoted_literals(serializer):
    generator = serializer.write_set(
        key="fields", values=["dimension_one", "dimension_two", "dimension_three"]
    )
    result = "".join(generator)
    print(result)
    assert (
        result == "fields: [\n  dimension_one,\n  dimension_two,\n  dimension_three\n]"
    )


def test_write_set_with_quoted_literals(serializer):
    generator = serializer.write_set(
        key="sortkeys", values=["column_one", "column_two", "column_three"]
    )
    result = "".join(generator)
    print(result)
    assert (
        result == 'sortkeys: [\n  "column_one",\n  "column_two",\n  "column_three"\n]'
    )


def test_write_set_with_no_values(serializer):
    generator = serializer.write_set(key="sortkeys", values=[])
    result = "".join(generator)
    print(result)
    assert result == "sortkeys: []"


def test_write_block_with_unquoted_literals(serializer):
    generator = serializer.write_block(
        key="bind_fields", fields={"from_field": "field_name", "to_field": "field_name"}
    )
    result = "".join(generator)
    print(result)
    assert result == "".join(
        (
            "bind_fields: {\n",
            "  from_field: field_name\n",
            "  to_field: field_name\n",
            "}",
        )
    )


def test_write_block_with_quoted_literals(serializer):
    generator = serializer.write_block(
        key="dimension",
        fields={
            "label": "Dimension Name",
            "group_label": "Group Name",
            "description": "A dimension description.",
        },
    )
    result = "".join(generator)
    print(result)
    assert result == "".join(
        (
            "dimension: {\n",
            '  label: "Dimension Name"\n',
            '  group_label: "Group Name"\n',
            '  description: "A dimension description."\n',
            "}",
        )
    )


def test_write_block_with_name(serializer):
    generator = serializer.write_block(
        key="dimension", fields={"label": "Dimension Name"}, name="dimension_name"
    )
    result = "".join(generator)
    print(result)
    assert result == "".join(
        ("dimension: dimension_name {\n", '  label: "Dimension Name"\n', "}")
    )


def test_write_block_with_no_fields_and_name(serializer):
    generator = serializer.write_block(
        key="dimension", fields={}, name="dimension_name"
    )
    result = "".join(generator)
    print(result)
    assert result == "dimension: dimension_name {}"


def test_write_block_with_no_fields_and_no_name(serializer):
    generator = serializer.write_block(key="dimension", fields={}, name=None)
    result = "".join(generator)
    print(result)
    assert result == "dimension: {}"


def test_write_nested_block(serializer):
    generator = serializer.write_block(
        key="derived_table",
        fields={
            "explore_source": {
                "bind_filters": {"from_field": "field_name", "to_field": "field_name"},
                "name": "explore_name",
            }
        },
    )

    result = "".join(generator)
    print(result)
    assert result == "".join(
        (
            "derived_table: {\n",
            "  explore_source: explore_name {\n",
            "    bind_filters: {\n",
            "      from_field: field_name\n",
            "      to_field: field_name\n",
            "    }\n",
            "  }\n",
            "}",
        )
    )


def test_write_any_with_str_value(serializer):
    generator = serializer.write_any(key="hidden", value="yes")
    result = "".join(generator)
    print(result)
    assert result == "hidden: yes"


def test_write_any_with_list_value(serializer):
    generator = serializer.write_any(key="sortkeys", value=["column_one", "column_two"])
    result = "".join(generator)
    print(result)
    assert result == 'sortkeys: [\n  "column_one",\n  "column_two"\n]'


def test_write_any_with_dict_value_and_name(serializer):
    generator = serializer.write_any(
        key="dimension", value={"name": "dimension_name", "label": "Dimension Name"}
    )
    result = "".join(generator)
    print(result)
    assert result == "".join(
        ("dimension: dimension_name {\n", '  label: "Dimension Name"\n', "}")
    )


def test_write_any_with_dict_value_and_name(serializer):
    generator = serializer.write_any(key="dimension", value={"label": "Dimension Name"})
    result = "".join(generator)
    print(result)
    assert result == "".join(("dimension: {\n", '  label: "Dimension Name"\n', "}"))


def test_expand_list_with_blocks(serializer):
    generator = serializer.expand_list(
        key="dimensions", values=[{"name": "dimension_one"}, {"name": "dimension_two"}]
    )
    result = "".join(generator)
    print(result)
    assert result == "dimension: dimension_one {}\ndimension: dimension_two {}"


def test_expand_list_with_pairs(serializer):
    generator = serializer.expand_list(
        key="includes", values=["filename_or_pattern_one", "filename_or_pattern_two"]
    )
    result = "".join(generator)
    print(result)
    assert (
        result == "include: filename_or_pattern_one\ninclude: filename_or_pattern_two"
    )


def test_serialize_view_with_multiple_dimensions(serializer):
    generator = serializer.write_any(
        key="views",
        value=[
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
        ],
    )
    result = "".join(generator)
    print(result)
    assert result == "".join(
        (
            "view: view_name {\n",
            "  sql_table_name: schema.table_name ;;\n",
            "  dimension: a_dimension {\n",
            "    type: string\n",
            "    sql: ${TABLE}.a_dimension ;;\n",
            "  }\n",
            "  dimension: another_dimension {\n",
            "    type: number\n",
            "    sql: ${TABLE}.another_dimension ;;\n",
            "  }\n",
            "  dimension: yet_another_dimension {\n",
            "    type: yesno\n",
            "    sql: ${TABLE}.yet_another_dimension ;;\n",
            "  }\n",
            "  dimension_group: a_dimension_group {\n",
            "    type: time\n",
            "    timeframes: [\n",
            "      raw,\n",
            "      time,\n",
            "      hour_of_day,\n",
            "      date,\n",
            "      day_of_week,\n",
            "      week,\n",
            "      month,\n",
            "      quarter,\n",
            "      year\n",
            "    ]\n",
            "    sql: ${TABLE}.a_dimension_group ;;\n",
            "  }\n",
            "}",
        )
    )
