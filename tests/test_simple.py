import pytest
from lkml.simple import DictParser


@pytest.fixture
def parser():
    return DictParser()


def test_parse_token_with_unquoted_literal(parser):
    token = parser.parse_token(key="hidden", value="no")
    result = str(token)
    print(result)
    assert result == "no"


def test_parse_token_with_quoted_literal(parser):
    token = parser.parse_token(key="label", value="Dimension Name")
    result = str(token)
    print(result)
    assert result == '"Dimension Name"'


def test_parse_pair_with_unquoted_literal(parser):
    node = parser.parse_pair(key="hidden", value="no")
    result = str(node)
    print(result)
    assert result == "hidden: no"


def test_parse_pair_with_quoted_literal(parser):
    node = parser.parse_pair(key="label", value="Dimension Name")
    result = str(node)
    print(result)
    assert result == 'label: "Dimension Name"'


def test_parse_list_with_unquoted_literals(parser):
    node = parser.parse_list(
        key="fields", values=["dimension_one", "dimension_two", "dimension_three"]
    )
    result = str(node)
    print(result)
    assert result == "fields: [dimension_one, dimension_two, dimension_three]"


def test_parse_list_with_quoted_literals(parser):
    node = parser.parse_list(
        key="sortkeys", values=["column_one", "column_two", "column_three"]
    )
    result = str(node)
    print(result)
    assert result == 'sortkeys: ["column_one", "column_two", "column_three"]'


def test_parse_list_with_many_values(parser):
    node = parser.parse_list(
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
            "  year,\n",
            "]",
        )
    )


def test_parse_list_with_no_values(parser):
    node = parser.parse_list(key="sortkeys", values=[])
    result = str(node)
    print(result)
    assert result == "sortkeys: []"


def test_parse_block_with_unquoted_literals(parser):
    node = parser.parse_block(
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


def test_parse_block_with_quoted_literals(parser):
    node = parser.parse_block(
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


def test_parse_block_with_name(parser):
    node = parser.parse_block(
        key="dimension", items={"label": "Dimension Name"}, name="dimension_name"
    )
    result = str(node)
    print(result)
    assert result == "".join(
        ("dimension: dimension_name {\n", '  label: "Dimension Name"\n', "}")
    )


def test_parse_block_with_no_fields_and_name(parser):
    node = parser.parse_block(key="dimension", items={}, name="dimension_name")
    result = str(node)
    print(result)
    assert result == "dimension: dimension_name {}"


def test_parse_block_with_no_fields_and_no_name(parser):
    node = parser.parse_block(key="dimension", items={}, name=None)
    result = str(node)
    print(result)
    assert result == "dimension: {}"


def test_parse_nested_block(parser):
    node = parser.parse_block(
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


def test_parse_any_with_str_value(parser):
    node = parser.parse_any(key="hidden", value="yes")
    result = str(node)
    print(result)
    assert result == "hidden: yes"


def test_parse_any_with_list_value(parser):
    node = parser.parse_any(key="sortkeys", value=["column_one", "column_two"])
    result = str(node)
    print(result)
    assert result == 'sortkeys: ["column_one", "column_two"]'


def test_parse_any_with_dict_value_and_name(parser):
    node = parser.parse_any(
        key="dimension", value={"name": "dimension_name", "label": "Dimension Name"}
    )
    result = str(node)
    print(result)
    assert result == "".join(
        ("dimension: dimension_name {\n", '  label: "Dimension Name"\n', "}")
    )


def test_parse_any_with_dict_value_and_no_name(parser):
    node = parser.parse_any(key="dimension", value={"label": "Dimension Name"})
    result = str(node)
    print(result)
    assert result == "".join(("dimension: {\n", '  label: "Dimension Name"\n', "}"))


def test_parse_any_raises_with_bad_type(parser):
    with pytest.raises(TypeError):
        parser.parse_any("sql", 100)


def test_expand_list_with_blocks(parser):
    nodes = parser.expand_list(
        key="dimensions", values=[{"name": "dimension_one"}, {"name": "dimension_two"}]
    )
    result = "".join(str(node) for node in nodes)
    print(result)
    assert result == "dimension: dimension_one {}\n\ndimension: dimension_two {}"


def test_expand_list_with_pairs(parser):
    nodes = parser.expand_list(
        key="includes", values=["filename_or_pattern_one", "filename_or_pattern_two"]
    )
    result = "".join(str(node) for node in nodes)
    print(result)
    assert (
        result
        == 'include: "filename_or_pattern_one"\ninclude: "filename_or_pattern_two"'
    )


def test_parse_top_level_pairs(parser):
    obj = {
        "connection": "c53-looker",
        "includes": ["*.view"],
        "fiscal_month_offset": "0",
        "week_start_day": "sunday",
    }
    node = parser.parse(obj)
    result = str(node)
    print(result)
    assert result == "".join(
        (
            'connection: "c53-looker"\n',
            'include: "*.view"\n',
            "fiscal_month_offset: 0\n",
            "week_start_day: sunday",
        )
    )


def test_parse_query(parser):
    obj = {
        "queries": [
            {
                "name": "query_one",
                "dimensions": ["dimension_one", "dimension_two"],
                "measures": ["measure_one"],
            }
        ]
    }
    node = parser.parse(obj)
    result = str(node)
    assert result == "\n".join(
        (
            "query: query_one {",
            "  dimensions: [dimension_one, dimension_two]",
            "  measures: [measure_one]",
            "}",
        )
    )


def test_parse_query_with_filters(parser):
    obj = {
        "explores": [
            {
                "queries": [{"filters__all": [[{"baz": "expression"}, {"qux": "expression"}]], "name": "bar"}],
                "name": "foo",
            }
        ]
    }
    node = parser.parse(obj)
    result = str(node)
    print(result)
    assert result == "\n".join(
        (
            "explore: foo {",
            "  query: bar {",
            "    filters: [",
            '      baz: "expression",',
            '      qux: "expression",',
            "    ]",
            "  }",
            "}",
        )
    )


def test_resolve_filters_filter_only_field(parser):
    nodes = parser.resolve_filters(
        [{"name": "filter_a", "type": "string"}, {"name": "filter_b", "type": "number"}]
    )
    result = "".join(str(node) for node in nodes)
    assert result == (
        "filter: filter_a {\n  type: string\n}\n\n"
        "filter: filter_b {\n  type: number\n}"
    )


def test_resolve_filters_legacy_filters(parser):
    nodes = parser.resolve_filters(
        [
            {"field": "dimension_a", "value": "-NULL"},
            {"field": "dimension_b", "value": ">5"},
        ]
    )
    result = "".join(str(node) for node in nodes)
    assert result == (
        'filters: {\n  field: dimension_a\n  value: "-NULL"\n}\n\n'
        'filters: {\n  field: dimension_b\n  value: ">5"\n}'
    )


def test_resolve_filters_new_filters(parser):
    node = parser.resolve_filters([{"dimension_a": "-NULL"}, {"dimension_b": ">5"}])
    result = str(node)
    assert result == 'filters: [\n  dimension_a: "-NULL",\n  dimension_b: ">5",\n]'
