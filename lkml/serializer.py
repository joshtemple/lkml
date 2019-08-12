"""Serializes a Python dictionary into a LookML string."""

from copy import deepcopy
from typing import Any, Dict, Iterator, Sequence, Union

from lkml.keys import (
    EXPR_BLOCK_KEYS,
    KEYS_WITH_NAME_FIELDS,
    PLURAL_KEYS,
    QUOTED_LITERAL_KEYS,
)


class Serializer:
    """Serializes a Python dictionary into a LookML string.

    Review the grammar specified for the Parser class to understand how LookML
    is represented. The grammar details the differences between blocks, pairs, keys,
    and values.

    Attributes:
        parent_key: The name of the key at the previous level in a LookML block
        level: The number of indentations appropriate for the current position
        field_counter: The position of the current field when serializing
            iterable objects
        base_indent: Whitespace representing one tab
        indent: An indent of whitespace dynamically sized for the current position
        newline_indent: A newline plus an indent string

    """

    def __init__(self):
        """Initializes the Serializer."""
        self.parent_key: str = None
        self.level: int = 0
        self.field_counter: int = 0
        self.base_indent: str = " " * 2
        self.indent: str = ""
        self.newline_indent: str = "\n"

    def increase_level(self) -> None:
        """Increases the indent level of the current line by one tab."""
        self.field_counter = 0
        self.level += 1
        self.update_indent()

    def decrease_level(self) -> None:
        """Decreases the indent level of the current line by one tab."""
        self.field_counter = 0
        self.level -= 1
        self.update_indent()

    def update_indent(self) -> None:
        """Sets the indent string based on the current level."""
        self.indent = self.base_indent * self.level
        self.newline_indent = "\n" + self.indent

    def is_plural_key(self, key: str) -> bool:
        """Returns True if the key is a repeatable key.

        For example, `dimension` can be repeated, but `sql` cannot be.

        The key `allowed_value` is a special case and changes behavior depending on its
        parent key. If its parent key is `access_grant`, it is a list and cannot be
        repeated. Otherwise, it can be repeated.

        """
        if key.endswith("s"):
            singular_key = key.rstrip("s")
            return singular_key in PLURAL_KEYS and not (
                singular_key == "allowed_value"
                and self.parent_key.rstrip("s") == "access_grant"
            )
        else:
            return False

    def serialize(self, obj: dict) -> str:  # noqa: D202
        """Returns a LookML string serialized from a dictionary."""

        def chain_with_newline():
            for key, value in deepcopy(obj).items():
                yield from self.write_any(key, value)
                yield "\n"

        return "".join(chain_with_newline())

    def expand_list(self, key: str, values: Sequence) -> Iterator[str]:
        """Expands and serializes a list of values for a repeatable key.

        This method is exclusively used for sequences of values with a repeated key like
        `dimensions` or `views`, which need to be serialized sequentially with a newline
        in between.

        Args:
            key: A repeatable LookML field type (e.g. "views" or "dimension_groups")
            values: A sequence of objects to be serialized

        Returns:
            A generator of serialized string chunks

        """
        modified_key = key.rstrip("s") if key not in ("filters") else key
        for i, value in enumerate(values):
            if i > 0:
                yield "\n"
            yield from self.write_any(modified_key, value)

    def write_any(
        self, key: str, value: Union[str, list, tuple, dict]
    ) -> Iterator[str]:
        """Dynamically serializes a Python object based on its type.

        Args:
            key: A LookML field type (e.g. "suggestions" or "hidden")
            value: A string, tuple, or list to serialize

        Raises:
            TypeError: If input value is not of a valid type

        Returns:
            A generator of serialized string chunks

        """
        if isinstance(value, str):
            yield from self.write_pair(key, value)
        elif isinstance(value, (list, tuple)):
            if self.is_plural_key(key):
                yield from self.expand_list(key, value)
            else:
                yield from self.write_set(key, value)
        elif isinstance(value, dict):
            if key in KEYS_WITH_NAME_FIELDS or "name" not in value.keys():
                name = None
            else:
                name = value.pop("name")
            yield from self.write_block(key, value, name)
        else:
            raise TypeError("Value must be a string, list, tuple, or dict.")

        self.field_counter += 1

    def write_block(
        self, key: str, fields: Dict[str, Any], name: str = None
    ) -> Iterator[str]:
        """Serializes a dictionary to a LookML block.

        Args:
            key: A LookML field type (e.g. "dimension")
            fields: A dictionary to serialize (e.g. {"sql": "${TABLE}.order_id"})
            name: An optional name of the block (e.g. "order_id")

        Returns:
            A generator of serialized string chunks

        """
        if self.field_counter > 0:
            yield "\n"

        yield from self.write_key(key)
        if name:
            yield f"{name} " + "{"
        else:
            yield "{"

        if fields:
            self.parent_key = key
            self.increase_level()
            yield "\n"
            for i, (key, value) in enumerate(fields.items()):
                if i > 0:
                    yield "\n"
                yield from self.write_any(key, value)
            self.decrease_level()
            yield self.newline_indent

        yield "}"

    def write_set(self, key: str, values: Sequence[str]) -> Iterator[str]:
        """Serializes a sequence to a LookML block.

        Args:
            key: A LookML field type (e.g. "fields")
            value: A sequence to serialize (e.g. ["orders.order_id", "orders.item"])

        Returns:
            A generator of serialized string chunks

        """
        # `suggestions` is only quoted when it's a set, so override the default
        force_quote = True if key == "suggestions" else False

        yield from self.write_key(key)
        yield "["

        if values:
            if len(values) > 5:
                self.increase_level()
                yield self.newline_indent
                for i, value in enumerate(values):
                    if i > 0:
                        yield f",{self.newline_indent}"
                    yield from self.write_value(key, value, force_quote)
                self.decrease_level()
                yield self.newline_indent
            else:
                for i, value in enumerate(values):
                    if i > 0:
                        yield f", "
                    yield from self.write_value(key, value, force_quote)
        yield "]"

    def write_pair(self, key: str, value: str) -> Iterator[str]:
        """Serializes a key and value to a LookML pair.

        Args:
            key: A LookML field type (e.g. "hidden")
            value: The value string (e.g. "yes")

        Returns:
            A generator of serialized string chunks

        """
        yield from self.write_key(key)
        yield from self.write_value(key, value)

    def write_key(self, key: str) -> Iterator[str]:
        """Serializes a key to LookML.

        Args:
            key: A LookML field type (e.g. "sql")

        Returns:
            A generator of serialized string chunks

        """
        yield f"{self.indent}{key}: "

    def write_value(
        self, key: str, value: str, force_quote: bool = False
    ) -> Iterator[str]:
        """Serializes a value to LookML, quoting it required by the key or forced.

        Args:
            key: A LookML field type (e.g. "hidden")
            value: The value string (e.g. "yes")
            force_quote: True if value should always be quoted

        Returns:
            A generator of serialized string chunks

        """
        if force_quote or key in QUOTED_LITERAL_KEYS:
            yield '"'
            yield value
            yield '"'
        elif key in EXPR_BLOCK_KEYS:
            yield value
            yield " ;;"
        else:
            yield value
