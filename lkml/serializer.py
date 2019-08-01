from lkml.keys import QUOTED_LITERAL_KEYS, EXPR_BLOCK_KEYS, PLURAL_KEYS


class Serializer:
    def __init__(self):
        self.indent_level = 0
        self.base_indent = " " * 2
        self.indent = ""

    def increase_indent_level(self):
        self.indent_level += 1
        self.update_indent()

    def decrease_indent_level(self):
        self.indent_level -= 1
        self.update_indent()

    def update_indent(self):
        self.indent = self.base_indent * self.indent_level

    def serialize_string(self, obj: str, key: str):
        if key in QUOTED_LITERAL_KEYS:
            yield '"'
            yield obj
            yield '"'
        elif key in EXPR_BLOCK_KEYS:
            yield obj
            yield " ;;"
        else:
            yield obj

    def serialize_dict(self, obj: dict):
        try:
            name = obj.pop("name")
        except KeyError as error:
            yield "{"
        else:
            yield f"{name} " + "{"
        if obj.values():
            self.increase_indent_level()
            for key, value in obj.items():
                yield f"\n{self.indent}{key}: "
                yield from self.serialize(value, key)
            self.decrease_indent_level()
            yield f"\n{self.indent}"
        yield "}"

    def serialize_list(self, obj: list, key: str):
        yield "["
        for i, value in enumerate(obj):
            if i > 0:
                yield ", "
            yield from self.serialize_string(value, key)
        yield "]"

    def serialize(self, obj, key: str = None):
        if isinstance(obj, dict):
            if self.indent_level > 0:
                yield from self.serialize_dict(obj)
            else:
                for key, value in obj.items():
                    yield from self.serialize(value, key)
        elif isinstance(obj, (list, tuple)):
            singular_key = key.rstrip("s")
            if singular_key in PLURAL_KEYS:
                for i, value in enumerate(obj):
                    if i > 0:
                        yield "\n" * 2
                    yield f"{singular_key}: "
                    yield from self.serialize_dict(value)
            else:
                yield from self.serialize_list(obj, key)
        elif isinstance(obj, str):
            yield from self.serialize_string(obj, key)
        elif isinstance(obj, bool):
            yield "yes" if obj else "no"
