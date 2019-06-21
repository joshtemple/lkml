from pathlib import Path
from pprint import pformat
from lkml.lexer import Lexer
from lkml.parser import Parser
import logging
import sys

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

handler = logging.StreamHandler()
handler.setLevel(logging.DEBUG)

formatter = logging.Formatter("%(name)s: %(message)s")

handler.setFormatter(formatter)
logger.addHandler(handler)

logger.error("Initialized logger")


def load(file_object):
    text = file_object.read()
    lexer = Lexer(text)
    tokens = lexer.scan()
    parser = Parser(tokens)
    result = parser.parse()
    logger.debug("\n" + pformat(result, indent=2) + "\n")
    return result
