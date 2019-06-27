from pathlib import Path
import logging
import pytest
import lkml


@pytest.fixture
def lookml_path():
    path = Path(__file__).parent / "resources" / "view_with_all_fields.view.lkml"
    return str(path)


def test_debug_flag_is_parsed_to_log_level_debug(lookml_path):
    args = lkml.parse_args([lookml_path, "-d"])
    assert args.log_level == logging.DEBUG
    args = lkml.parse_args([lookml_path, "--debug"])
    assert args.log_level == logging.DEBUG


def test_absence_of_debug_flag_is_parsed_to_log_level_warn(lookml_path):
    args = lkml.parse_args([lookml_path])
    assert args.log_level == logging.WARN
