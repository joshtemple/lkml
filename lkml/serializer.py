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

    def serialize_string(self, key: str, obj: str):
        if key in QUOTED_LITERAL_KEYS:
            yield '"'
            yield obj
            yield '"'
        elif key in EXPR_BLOCK_KEYS:
            yield obj
            yield " ;;"
        else:
            yield obj

    def serialize_dict(self, key, obj):
        try:
            name = obj.pop("name")
        except KeyError as error:
            yield "{"
        else:
            yield f"{name} " + "{"

        if obj:
            yield "\n"
            self.increase_indent_level()
            for key, value in obj.items():
                yield from self.serialize(key, value)
                yield "\n"
            self.decrease_indent_level()

        yield f"{self.indent}" + "}\n\n"

    def serialize_list(self, key: str, obj: list):
        if all(isinstance(item, str) for item in obj):
            if key is not None:
                yield f"{self.indent}{key}: "
            yield "["
            self.increase_indent_level()
            for i, value in enumerate(obj):
                if i > 0:
                    yield ","
                yield f"{self.newline_indent}"
                yield from self.serialize_string(key, value)
            self.decrease_indent_level()
            yield f"{self.newline_indent}]"
        else:
            for item in obj:
                yield from self.serialize(key=key.rstrip("s"), obj=item)

    def serialize(self, key, obj):
        if isinstance(obj, dict):
            if key is not None:
                yield f"{self.indent}{key}: "
                yield from self.serialize_dict(key, obj)
            else:
                for key, value in obj.items():
                    yield from self.serialize(key, value)
        elif isinstance(obj, (list, tuple)):
            yield from self.serialize_list(key, obj)
        elif isinstance(obj, str):
            if key is not None:
                yield f"{self.indent}{key}: "
            yield from self.serialize_string(key, obj)
        elif isinstance(obj, bool):
            if key is not None:
                yield f"{self.indent}{key}: "
            yield "yes" if obj else "no"
