from lkml.keys import QUOTED_LITERAL_KEYS, EXPR_BLOCK_KEYS


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

    def write_any(self, key: str, value):
        if isinstance(value, str):
            yield from self.write_pair(key, value)

        if isinstance(value, list):
            yield from self.write_set(key, value)

        if isinstance(value, dict):
            try:
                name = value.pop("name")
            except KeyError:
                name = None
            yield from self.write_block(key, value, name)

    def write_block(self, key: str, fields: dict, name=None):
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

    def write_set(self, key: str, values: list):
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

    # def serialize_string(self, key: str, obj: str):
    #     if key in QUOTED_LITERAL_KEYS:
    #         yield '"'
    #         yield obj
    #         yield '"'
    #     elif key in EXPR_BLOCK_KEYS:
    #         yield obj
    #         yield " ;;"
    #     else:
    #         yield obj
    #
    # def serialize_dict(self, key, obj):
    #     try:
    #         name = obj.pop("name")
    #     except KeyError as error:
    #         yield "{"
    #     else:
    #         yield f"{name} " + "{"
    #
    #     if obj:
    #         yield "\n"
    #         self.increase_indent_level()
    #         for key, value in obj.items():
    #             yield from self.serialize(key, value)
    #             yield "\n"
    #         self.decrease_indent_level()
    #
    #     yield f"{self.indent}" + "}\n\n"
    #
    # def serialize_list(self, key: str, obj: list):
    #     if all(isinstance(item, str) for item in obj):
    #         if key is not None:
    #             yield f"{self.indent}{key}: "
    #         yield "["
    #         self.increase_indent_level()
    #         for i, value in enumerate(obj):
    #             if i > 0:
    #                 yield ","
    #             yield f"{self.newline_indent}"
    #             yield from self.serialize_string(key, value)
    #         self.decrease_indent_level()
    #         yield f"{self.newline_indent}]"
    #     else:
    #         for item in obj:
    #             yield from self.serialize(key=key.rstrip("s"), obj=item)
    #
    # def serialize(self, key, obj):
    #     if isinstance(obj, dict):
    #         if key is not None:
    #             yield f"{self.indent}{key}: "
    #             yield from self.serialize_dict(key, obj)
    #         else:
    #             for key, value in obj.items():
    #                 yield from self.serialize(key, value)
    #     elif isinstance(obj, (list, tuple)):
    #         yield from self.serialize_list(key, obj)
    #     elif isinstance(obj, str):
    #         if key is not None:
    #             yield f"{self.indent}{key}: "
    #         yield from self.serialize_string(key, obj)
    #     elif isinstance(obj, bool):
    #         if key is not None:
    #             yield f"{self.indent}{key}: "
    #         yield "yes" if obj else "no"
