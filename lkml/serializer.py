from lkml.keys import QUOTED_LITERAL_KEYS


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

    def serialize_dict(self, obj: dict):
        try:
            name = obj.pop("name")
        except KeyError as error:
            yield "{"
        else:
            yield f"{name} " + "{"
        self.increase_indent_level()
        for key, value in obj.items():
            yield f"\n{self.indent}{key}: "
            serialized = self.serialize(value)
            if key in QUOTED_LITERAL_KEYS:
                yield '"'
                yield from serialized
                yield '"'
            else:
                yield from serialized
        self.decrease_indent_level()
        yield f"\n{self.indent}" + "}"

    def serialize(self, obj):
        if isinstance(obj, dict):
            yield from self.serialize_dict(obj)
        elif isinstance(obj, str):
            yield obj
        elif isinstance(obj, bool):
            yield "yes" if obj else "no"
