import logging
import sys
import argparse
import json
from pathlib import Path
from lkml.lexer import Lexer
from lkml.parser import Parser


def load(file_object, allow_dupe_model_keys=False):
    text = file_object.read()
    lexer = Lexer(text)
    tokens = lexer.scan()
    parser = Parser(tokens)
    parser.set_allow_dupe_model_keys(allow_dupe_model_keys)
    result = parser.parse()
    return result


def parse_args(args):
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
    parser.add_argument(
        "--dupe_model_keys",
        dest="dupe_model_keys",
        default=False,
        help="allow dupe model keys",
    )

    return parser.parse_args(args)


def cli():
    logger = logging.getLogger()
    logger.setLevel(logging.WARN)

    handler = logging.StreamHandler()
    handler.setLevel(logging.DEBUG)

    formatter = logging.Formatter("%(name)s . %(message)s")

    handler.setFormatter(formatter)
    logger.addHandler(handler)

    args = parse_args(sys.argv[1:])

    logging.getLogger().setLevel(args.log_level)

    allow_dupe_model_keys = False
    if args.allow_dupe_model_keys is not None:
        allow_dupe_model_keys = args.dupe_model_keys

    lookml = load(args.file, allow_dupe_model_keys)
    args.file.close()

    json_string = json.dumps(lookml, indent=2)
    print(json_string)


if __name__ == "__main__":
    cli()
