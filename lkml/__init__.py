"""Public interface for lkml."""
import argparse
import json
import logging
import sys
from typing import IO, Any, List

from lkml.lexer import Lexer
from lkml.parser import Parser
from lkml.serializer import Serializer


def load(stream: IO[Any]) -> List[dict]:
    """Parse LookML from a stream into a Python object

    Args:
        stream (TextIO): File or stream containing raw LookML

    Returns:
        List[dict]: Parsed LookML

    """
    try:
        text = stream.read()
    except AttributeError:
        text = stream
    lexer = Lexer(text)
    tokens = lexer.scan()
    parser = Parser(tokens)
    result = parser.parse()
    return result


def dump(obj, file_object=None):
    serializer = Serializer()
    result = serializer.serialize(obj)
    if file_object:
        file_object.write(result)
    else:
        return result


def parse_args(args: list) -> argparse.Namespace:
    """Parse CLI arguments."""
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
        "-d",
        "--debug",
        action="store_const",
        dest="log_level",
        const=logging.DEBUG,
        default=logging.WARN,
        help="increase logging verbosity",
    )

    return parser.parse_args(args)


def cli():
    """CLI for lkml."""
    logger = logging.getLogger()
    logger.setLevel(logging.WARN)

    handler = logging.StreamHandler()
    handler.setLevel(logging.DEBUG)

    formatter = logging.Formatter("%(name)s %(levelname)s: %(message)s")

    handler.setFormatter(formatter)
    logger.addHandler(handler)

    args = parse_args(sys.argv[1:])

    logging.getLogger().setLevel(args.log_level)

    lookml = load(args.file)
    args.file.close()

    json_string = json.dumps(lookml, indent=2)
    print(json_string)


if __name__ == "__main__":
    cli()
