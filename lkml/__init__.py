import argparse
import io
import json
import logging
import sys
from typing import IO, Optional, Sequence, Union

from lkml.lexer import Lexer
from lkml.parser import Parser
from lkml.serializer import Serializer


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
    lexer = Lexer(text)
    tokens = lexer.scan()
    parser = Parser(tokens)
    result = parser.parse()
    return result


def dump(obj: dict, file_object: IO = None) -> Optional[str]:
    """Serialize a Python dictionary into LookML.

    Args:
        obj: The Python dictionary to be serialized to LookML
        file_object: An optional file object to save the LookML string to

    Returns:
        A LookML string if no file_object is passed

    """
    serializer = Serializer()
    result = serializer.serialize(obj)
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

    lookml = load(args.file)
    args.file.close()

    json_string = json.dumps(lookml, indent=2)
    print(json_string)


if __name__ == "__main__":
    cli()
