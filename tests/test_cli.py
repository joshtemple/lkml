import io
from lkml.tree import ContainerNode, DocumentNode, PairNode, SyntaxToken
from pathlib import Path
from unittest.mock import patch
import logging
import pytest
import lkml


@pytest.fixture
def lookml_path():
    path = Path(__file__).parent / "resources" / "view_with_all_fields.view.lkml"
    return str(path)


def test_debug_flag_is_parsed_to_log_level_debug(lookml_path):
    args = lkml.parse_args([lookml_path, "-v"])
    assert args.log_level == logging.DEBUG
    args = lkml.parse_args([lookml_path, "--verbose"])
    assert args.log_level == logging.DEBUG


def test_absence_of_debug_flag_is_parsed_to_log_level_warn(lookml_path):
    args = lkml.parse_args([lookml_path])
    assert args.log_level == logging.WARN


@patch("lkml.load")
@patch("lkml.parse_args")
def test_run_cli(mock_parse_args, mock_load, lookml_path):
    mock_parse_args.return_value.file = io.StringIO()
    mock_parse_args.return_value.log_level = logging.WARN
    mock_load.return_value = {"a": "1"}
    lkml.cli()


def test_load_with_bad_argument_raises_type_error():
    with pytest.raises(TypeError):
        lkml.load(stream=100)
