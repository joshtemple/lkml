import lkml
from pathlib import Path

TEST_RESOURCES_PATH = Path(__file__).parent / "resources"


def test_load_simple_view():
    filename = TEST_RESOURCES_PATH / "simple.view.lkml"
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
