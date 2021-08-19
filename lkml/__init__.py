"""A speedy LookML parser and serializer implemented in pure Python."""

import argparse
import io
import json
import logging
import sys
from typing import IO, Optional, Sequence, Union

from lkml.lexer import Lexer
from lkml.parser import Parser
from lkml.simple import DictParser, DictVisitor
from lkml.tree import DocumentNode


def parse(text: str) -> DocumentNode:
    """Parse LookML into a parse tree.

    Args:
        text: The LookML string to be parsed.

    Returns:
        A document node, the root of the parse tree.

    """
    lexer = Lexer(text)
    tokens = lexer.scan()
    parser = Parser(tokens)
    tree: DocumentNode = parser.parse()
    return tree


def load(stream: Union[str, IO]) -> dict:
    """Parse LookML into a Python dictionary.

    Args:
        stream: File object or string containing LookML to be parsed

    Raises:
        TypeError: If stream is neither a string or a file object

    """

    if isinstance(stream, io.TextIOWrapper):
        text = stream.read()
    elif isinstance(stream, str):
        text = stream
    else:
        raise TypeError("Input stream must be a string or file object.")
    tree: DocumentNode = parse(text)
    visitor = DictVisitor()
    tree_as_dict: dict = visitor.visit(tree)
    return tree_as_dict


def dump(obj: dict, file_object: IO = None) -> Optional[str]:
    """Serialize a Python dictionary into LookML.

    Args:
        obj: The Python dictionary to be serialized to LookML
        file_object: An optional file object to save the LookML string to

    Returns:
        A LookML string if no file_object is passed

    """
    parser = DictParser()
    tree: DocumentNode = parser.parse(obj)
    result = str(tree)
    if file_object:
        file_object.write(result)
        return None
    else:
        return result


def parse_args(args: Sequence) -> argparse.Namespace:
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description=(
            "A blazing fast LookML parser, implemented in pure Python. "
            "When invoked from the command line, "
            "returns the parsed output as a JSON string."
        )
    )
    parser.add_argument(
        "file", type=argparse.FileType("r"), help="path to the LookML file to parse"
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_const",
        dest="log_level",
        const=logging.DEBUG,
        default=logging.WARN,
        help="increase logging verbosity to debug",
    )

    return parser.parse_args(args)


def cli():
    """Command-line entry point for lkml."""
    logger = logging.getLogger()
    logger.setLevel(logging.WARN)

    handler = logging.StreamHandler()
    handler.setLevel(logging.DEBUG)

    formatter = logging.Formatter("%(name)s %(levelname)s: %(message)s")

    handler.setFormatter(formatter)
    logger.addHandler(handler)

    args = parse_args(sys.argv[1:])

    logging.getLogger().setLevel(args.log_level)

    result: dict = load(args.file)
    args.file.close()

    json_string = json.dumps(result, indent=2)
    print(json_string)
