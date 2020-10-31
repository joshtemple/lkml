import pytest
from lkml.interface import DictParser


@pytest.fixture
def parser():
    return DictParser()


def test_write_token_with_unquoted_literal(parser):
    token = parser.write_token(key="hidden", value="no")
    result = str(token)
    print(result)
    assert result == "no"


def test_write_token_with_quoted_literal(parser):
    token = parser.write_token(key="label", value="Dimension Name")
    result = str(token)
    print(result)
    assert result == '"Dimension Name"'


def test_write_pair_with_unquoted_literal(parser):
    node = parser.write_pair(key="hidden", value="no")
    result = str(node)
    print(result)
    assert result == "hidden: no"


def test_write_pair_with_quoted_literal(parser):
    node = parser.write_pair(key="label", value="Dimension Name")
    result = str(node)
    print(result)
    assert result == 'label: "Dimension Name"'


def test_write_list_with_unquoted_literals(parser):
    node = parser.write_list(
        key="fields", values=["dimension_one", "dimension_two", "dimension_three"]
    )
    result = str(node)
    print(result)
    assert result == "fields: [dimension_one, dimension_two, dimension_three]"


def test_write_list_with_quoted_literals(parser):
    node = parser.write_list(
        key="sortkeys", values=["column_one", "column_two", "column_three"]
    )
    result = str(node)
    print(result)
    assert result == 'sortkeys: ["column_one", "column_two", "column_three"]'


def test_write_list_with_many_values(parser):
    node = parser.write_list(
        key="timeframes",
        values=[
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
    )
    result = str(node)
    print(result)
    assert result == "".join(
        (
            "timeframes: [\n",
            "  raw,\n",
            "  time,\n",
            "  hour_of_day,\n",
            "  date,\n",
            "  day_of_week,\n",
            "  week,\n",
            "  month,\n",
            "  quarter,\n",
            "  year\n",
            "]",
        )
    )


def test_write_list_with_no_values(parser):
    node = parser.write_list(key="sortkeys", values=[])
    result = str(node)
    print(result)
    assert result == "sortkeys: []"


def test_write_block_with_unquoted_literals(parser):
    node = parser.write_block(
        key="bind_fields", items={"from_field": "field_name", "to_field": "field_name"}
    )
    result = str(node)
    print(result)
    assert result == "".join(
        (
            "bind_fields: {\n",
            "  from_field: field_name\n",
            "  to_field: field_name\n",
            "}",
        )
    )


def test_write_block_with_quoted_literals(parser):
    node = parser.write_block(
        key="dimension",
        items={
            "label": "Dimension Name",
            "group_label": "Group Name",
            "description": "A dimension description.",
        },
    )
    result = str(node)
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


def test_write_block_with_name(parser):
    node = parser.write_block(
        key="dimension", items={"label": "Dimension Name"}, name="dimension_name"
    )
    result = str(node)
    print(result)
    assert result == "".join(
        ("dimension: dimension_name {\n", '  label: "Dimension Name"\n', "}")
    )


def test_write_block_with_no_fields_and_name(parser):
    node = parser.write_block(key="dimension", items={}, name="dimension_name")
    result = str(node)
    print(result)
    assert result == "dimension: dimension_name {}"


def test_write_block_with_no_fields_and_no_name(parser):
    node = parser.write_block(key="dimension", items={}, name=None)
    result = str(node)
    print(result)
    assert result == "dimension: {}"


def test_write_nested_block(parser):
    node = parser.write_block(
        key="derived_table",
        items={
            "explore_source": {
                "bind_filters": {"from_field": "field_name", "to_field": "field_name"},
                "name": "explore_name",
            }
        },
    )

    result = str(node)
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


def test_write_any_with_str_value(parser):
    node = parser.write_any(key="hidden", value="yes")
    result = str(node)
    print(result)
    assert result == "hidden: yes"


def test_write_any_with_list_value(parser):
    node = parser.write_any(key="sortkeys", value=["column_one", "column_two"])
    result = str(node)
    print(result)
    assert result == 'sortkeys: ["column_one", "column_two"]'


def test_write_any_with_dict_value_and_name(parser):
    node = parser.write_any(
        key="dimension", value={"name": "dimension_name", "label": "Dimension Name"}
    )
    result = str(node)
    print(result)
    assert result == "".join(
        ("dimension: dimension_name {\n", '  label: "Dimension Name"\n', "}")
    )


def test_write_any_with_dict_value_and_no_name(parser):
    node = parser.write_any(key="dimension", value={"label": "Dimension Name"})
    result = str(node)
    print(result)
    assert result == "".join(("dimension: {\n", '  label: "Dimension Name"\n', "}"))


def test_any_raises_with_bad_type(parser):
    node = parser.write_any("sql", 100)
    with pytest.raises(TypeError):
        str(node)


def test_expand_list_with_blocks(parser):
    node = parser.expand_list(
        key="dimensions", values=[{"name": "dimension_one"}, {"name": "dimension_two"}]
    )
    result = str(node)
    print(result)
    assert result == "dimension: dimension_one {}\n\ndimension: dimension_two {}"


def test_expand_list_with_pairs(parser):
    node = parser.expand_list(
        key="includes", values=["filename_or_pattern_one", "filename_or_pattern_two"]
    )
    result = str(node)
    print(result)
    assert (
        result
        == 'include: "filename_or_pattern_one"\ninclude: "filename_or_pattern_two"'
    )


def test_serialize_view_with_multiple_dimensions(parser):
    node = parser.write_any(
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
    result = str(node)
    print(result)
    assert result == "".join(
        (
            "view: view_name {\n",
            "  sql_table_name: schema.table_name ;;\n\n",
            "  dimension: a_dimension {\n",
            "    type: string\n",
            "    sql: ${TABLE}.a_dimension ;;\n",
            "  }\n\n",
            "  dimension: another_dimension {\n",
            "    type: number\n",
            "    sql: ${TABLE}.another_dimension ;;\n",
            "  }\n\n",
            "  dimension: yet_another_dimension {\n",
            "    type: yesno\n",
            "    sql: ${TABLE}.yet_another_dimension ;;\n",
            "  }\n\n",
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


def test_serialize_top_level_pairs(parser):
    obj = {
        "connection": "c53-looker",
        "includes": ["*.view"],
        "fiscal_month_offset": "0",
        "week_start_day": "sunday",
    }
    result = parser.serialize(obj)
    print(result)
    assert result == "".join(
        (
            'connection: "c53-looker"\n',
            'include: "*.view"\n',
            "fiscal_month_offset: 0\n",
            "week_start_day: sunday\n",
        )
    )
