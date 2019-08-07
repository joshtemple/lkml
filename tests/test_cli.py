import io
import logging
from unittest.mock import patch

import lkml


def test_debug_flag_is_parsed_to_log_level_debug(lookml_path):
    args = lkml.parse_args([lookml_path, "-d"])
    assert args.log_level == logging.DEBUG
    args = lkml.parse_args([lookml_path, "--debug"])
    assert args.log_level == logging.DEBUG


def test_absence_of_debug_flag_is_parsed_to_log_level_warn(lookml_path):
    args = lkml.parse_args([lookml_path])
    assert args.log_level == logging.WARN


@patch("lkml.load")
@patch("lkml.parse_args")
def test_run_cli(mock_parse_args, mock_load, lookml_path):
    mock_parse_args.return_value.file = io.StringIO()
    mock_parse_args.return_value.log_level = logging.WARN
    mock_load.return_value = {"a": 1}
    lkml.cli()
