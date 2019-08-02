from copy import deepcopy
from typing import Iterable, Dict, Any
from lkml.keys import QUOTED_LITERAL_KEYS, PLURAL_KEYS, EXPR_BLOCK_KEYS


class Serializer:
    def __init__(self):
        self.indent_level = 0
        self.base_indent = " " * 2
        self.indent = ""
        self.newline_indent = "\n"

    def increase_indent_level(self):
        self.indent_level += 1
        self.update_indent()

    def decrease_indent_level(self):
        self.indent_level -= 1
        self.update_indent()

    def update_indent(self):
        self.indent = self.base_indent * self.indent_level
        self.newline_indent = "\n" + self.indent

    @staticmethod
    def is_plural_key(key):
        return key.endswith("s") and key.rstrip("s") in PLURAL_KEYS

    def serialize(self, obj: Dict):
        def chain_with_newline():
            for key, value in deepcopy(obj).items():
                yield from self.write_any(key, value)
                yield "\n"

        return "".join(chain_with_newline())

    def expand_list(self, key: str, values: Iterable):
        modified_key = (
            key.rstrip("s") if key not in ("filters", "allowed_values") else key
        )
        for i, value in enumerate(values):
            if i > 0:
                yield "\n"
            yield from self.write_any(modified_key, value)

    def write_any(self, key: str, value: Any):
        if isinstance(value, str):
            yield from self.write_pair(key, value)

        if isinstance(value, (list, tuple)):
            if self.is_plural_key(key):
                yield from self.expand_list(key, value)
            else:
                yield from self.write_set(key, value)

        if isinstance(value, dict):
            try:
                name = value.pop("name")
            except KeyError:
                name = None
            yield from self.write_block(key, value, name)

    def write_block(self, key: str, fields: Dict[str, Any], name: str = None):
        yield from self.write_key(key)
        if name:
            yield f"{name} " + "{"
        else:
            yield "{"

        if fields:
            self.increase_indent_level()
            yield "\n"
            for i, (key, value) in enumerate(fields.items()):
                if i > 0:
                    yield "\n"
                yield from self.write_any(key, value)
            self.decrease_indent_level()
            yield self.newline_indent

        yield "}"

    def write_set(self, key: str, values: Iterable[str]):
        yield from self.write_key(key)
        yield "["

        if values:
            self.increase_indent_level()
            yield self.newline_indent
            for i, value in enumerate(values):
                if i > 0:
                    yield f",{self.newline_indent}"
                yield from self.write_value(key, value)
            self.decrease_indent_level()
            yield self.newline_indent

        yield "]"

    def write_pair(self, key: str, value: str):
        yield from self.write_key(key)
        yield from self.write_value(key, value)

    def write_key(self, key: str):
        yield f"{self.indent}{key}: "

    def write_value(self, key: str, value: str):
        if key in QUOTED_LITERAL_KEYS:
            yield '"'
            yield value
            yield '"'
        elif key in EXPR_BLOCK_KEYS:
            yield value
            yield " ;;"
        else:
            yield value
