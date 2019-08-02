from copy import deepcopy
from typing import Iterable, Dict, Any, Optional, Iterator
from lkml.keys import QUOTED_LITERAL_KEYS, PLURAL_KEYS, EXPR_BLOCK_KEYS

# TODO: Don't expand lists if they're short
# TODO: Add whitespace before blocks if they aren't the 1st ones


class Serializer:
    def __init__(self):
        self.indent_level = 0
        self.base_indent = " " * 2
        self.indent = ""
        self.newline_indent = "\n"

    def increase_indent_level(self) -> None:
        self.indent_level += 1
        self.update_indent()

    def decrease_indent_level(self) -> None:
        self.indent_level -= 1
        self.update_indent()

    def update_indent(self) -> None:
        self.indent = self.base_indent * self.indent_level
        self.newline_indent = "\n" + self.indent

    @staticmethod
    def is_plural_key(key) -> bool:
        return key.endswith("s") and key.rstrip("s") in PLURAL_KEYS

    def serialize(self, obj: Dict) -> str:
        def chain_with_newline():
            for key, value in deepcopy(obj).items():
                yield from self.write_any(key, value)
                yield "\n"

        return "".join(chain_with_newline())

    def expand_list(self, key: str, values: Iterable) -> Iterator[str]:
        modified_key = (
            key.rstrip("s") if key not in ("filters", "allowed_values") else key
        )
        for i, value in enumerate(values):
            if i > 0:
                yield "\n"
            yield from self.write_any(modified_key, value)

    def write_any(self, key: str, value: Any) -> Iterator[str]:
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

    def write_block(
        self, key: str, fields: Dict[str, Any], name: str = None
    ) -> Iterator[str]:
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

    def write_set(self, key: str, values: Iterable[str]) -> Iterator[str]:
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

    def write_pair(self, key: str, value: str) -> Iterator[str]:
        yield from self.write_key(key)
        yield from self.write_value(key, value)

    def write_key(self, key: str) -> Iterator[str]:
        yield f"{self.indent}{key}: "

    def write_value(self, key: str, value: str) -> Iterator[str]:
        if key in QUOTED_LITERAL_KEYS:
            yield '"'
            yield value
            yield '"'
        elif key in EXPR_BLOCK_KEYS:
            yield value
            yield " ;;"
        else:
            yield value
