import lkml


def test_load_simple_view():
    filename = "./resources/simple.view.lkml"
    parsed = lkml.load(filename)
    assert parsed == {
        "sql_table_name": "schema.table_name",
        "dimensions": [
            {
                "name": "dimension_name",
                "label": "Dimension Label",
                "group_label": "Group Label",
            }
        ],
    }
