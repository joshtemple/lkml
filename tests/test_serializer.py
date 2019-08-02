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


# def test_serialize_dict_with_unquoted_literals(serializer):
#     generator = serializer.serialize_dict(
#         key="bind_fields", obj={"from_field": "field_name", "to_field": "field_name"}
#     )
#     result = "".join(generator)
#     print(result)
#     assert result == "".join(
#         ("{\n", "  from_field: field_name\n", "  to_field: field_name\n", "}")
#     )
#
#
# def test_serialize_dict_with_quoted_literals(serializer):
#     generator = serializer.serialize_dict(
#         key="dimension",
#         obj={
#             "label": "Dimension Name",
#             "group_label": "Group Name",
#             "description": "A dimension description.",
#         },
#     )
#     result = "".join(generator)
#     print(result)
#     assert result == "".join(
#         (
#             "{\n",
#             '  label: "Dimension Name"\n',
#             '  group_label: "Group Name"\n',
#             '  description: "A dimension description."\n',
#             "}",
#         )
#     )
#
#
# def test_serialize_dict_with_name(serializer):
#     generator = serializer.serialize_dict(
#         key="dimension", obj={"name": "dimension_name", "label": "Dimension Name"}
#     )
#     result = "".join(generator)
#     print(result)
#     assert result == "".join(("dimension_name {\n", '  label: "Dimension Name"\n', "}"))
#
#
# def test_serialize_nested_dict(serializer):
#     generator = serializer.serialize_dict(
#         key="derived_table",
#         obj={
#             "explore_source": {
#                 "bind_filters": {"from_field": "field_name", "to_field": "field_name"},
#                 "name": "explore_name",
#             }
#         },
#     )
#     result = "".join(generator)
#     print(result)
#     assert result == "".join(
#         (
#             "{\n",
#             "  explore_source: explore_name {\n",
#             "    bind_filters: {\n",
#             "      from_field: field_name\n",
#             "      to_field: field_name\n",
#             "    }\n",
#             "  }\n",
#             "}",
#         )
#     )
#
#
# def test_serialize_empty_dict_with_name(serializer):
#     generator = serializer.serialize_dict(
#         key="dimension", obj={"name": "dimension_name"}
#     )
#     result = "".join(generator)
#     print(result)
#     assert result == "dimension_name {}"
#
#
# def test_serialize_empty_dict_without_name(serializer):
#     generator = serializer.serialize_dict(key="dimension", obj={})
#     result = "".join(generator)
#     print(result)
#     assert result == "{}"
#
#
# def test_serialize_list_with_unquoted_literals(serializer):
#     generator = serializer.serialize_list(
#         key="fields", obj=["dimension_one", "dimension_two", "dimension_three"]
#     )
#     result = "".join(generator)
#     print(result)
#     assert result == "[\n  dimension_one,\n  dimension_two,\n  dimension_three\n]"
#
#
# def test_serialize_list_with_quoted_literals(serializer):
#     generator = serializer.serialize_list(
#         key="sortkeys", obj=["column_one", "column_two", "column_three"]
#     )
#     result = "".join(generator)
#     print(result)
#     assert result == '[\n  "column_one",\n  "column_two",\n  "column_three"\n]'
#
#
# def test_serialize_with_plural_key(serializer):
#     generator = serializer.serialize(
#         key=None,
#         obj={"dimensions": [{"name": "dimension_one"}, {"name": "dimension_two"}]},
#     )
#     # print(list(generator))
#     result = "".join(generator)
#     print(result)
#     assert result == "dimension: dimension_one {}\n\ndimension: dimension_two {}"
#
#
# def test_serialize_view_with_multiple_dimensions(serializer):
#     generator = serializer.serialize(
#         key=None,
#         obj={
#             "views": [
#                 {
#                     "sql_table_name": "schema.table_name",
#                     "dimensions": [
#                         {
#                             "type": "string",
#                             "sql": "${TABLE}.a_dimension",
#                             "name": "a_dimension",
#                         },
#                         {
#                             "type": "number",
#                             "sql": "${TABLE}.another_dimension",
#                             "name": "another_dimension",
#                         },
#                         {
#                             "type": "yesno",
#                             "sql": "${TABLE}.yet_another_dimension",
#                             "name": "yet_another_dimension",
#                         },
#                     ],
#                     "dimension_groups": [
#                         {
#                             "type": "time",
#                             "timeframes": [
#                                 "raw",
#                                 "time",
#                                 "hour_of_day",
#                                 "date",
#                                 "day_of_week",
#                                 "week",
#                                 "month",
#                                 "quarter",
#                                 "year",
#                             ],
#                             "sql": "${TABLE}.a_dimension_group",
#                             "name": "a_dimension_group",
#                         }
#                     ],
#                     "name": "view_name",
#                 }
#             ]
#         },
#     )
#     result = "".join(generator)
#     print(result)
#     assert False
