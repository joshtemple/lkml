import io
import logging
import pytest
import lkml
import json

from pathlib import Path
from unittest.mock import patch


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


def test_load_with_bad_argument_raises_type_error():
    with pytest.raises(TypeError):
        lkml.load(stream=100)


def test_parse_default_option(lookml_path):
    args = lkml.parse_args([lookml_path])
    assert args.json is True
    assert args.lookml is False


def test_parse_options(lookml_path):
    args = lkml.parse_args([lookml_path, "--json"])
    assert args.json is True

    args = lkml.parse_args([lookml_path, "--lookml"])
    assert args.lookml is True

    with pytest.raises(SystemExit):
        args = lkml.parse_args([lookml_path, "--json", "--lookml"])


def test_run_cli_default_option(lookml_path, capsys):
    with patch("sys.argv", ["file.py", lookml_path]):
        lkml.cli()
        captured = capsys.readouterr()
        assert json.loads(captured.out) is not None
        assert captured.err == ""


def test_run_cli_options(lookml_path, capsys):
    with patch("sys.argv", ["file.py", "--json", lookml_path]):
        lkml.cli()
        captured = capsys.readouterr()
        assert json.loads(captured.out) is not None
        assert captured.err == ""

    with patch("sys.argv", ["file.py", "--lookml", lookml_path]):
        lkml.cli()
        captured = capsys.readouterr()
        assert lkml.load(captured.out) is not None
        assert captured.err == ""
