import logging
from parsimonious.grammar import Grammar, NodeVisitor


def load(filename):
    with open(filename, "r") as file:
        lookml = file.read()

    parser = Parser(lookml)
    return parser.parse()


class LookMlVisitor(NodeVisitor):
    def visit_expression(self, node, visited_children):
        _, expression = visited_children
        unstacked = []
        for value in expression:
            unstacked.extend(value)
        return unstacked

    def visit_block(self, node, visited_children):
        _, field_name, _, values, *_ = visited_children
        result = {}
        for value in values:
            if isinstance(value, dict):
                result.update(value)
            elif isinstance(value, tuple):
                result.update(dict([value]))
        return {field_name: result}

    def visit_field(self, node, visited_children):
        field_type, value = visited_children
        # TODO: Figure out how to handle parentheticals
        return field_type, value[0]

    def visit_field_type(self, node, visited_children):
        field_type, _, _ = visited_children
        return field_type.text

    def visit_field_name(self, node, visited_children):
        field_name, _ = visited_children
        return field_name.text

    def visit_quoted_literal(self, node, visited_children):
        _, literal, *_ = visited_children
        return literal.text

    def visit_literal(self, node, visited_children):
        literal, _ = visited_children
        text = literal[0].text
        if text == "yes":
            return True
        elif text == "no":
            return False
        else:
            return text

    def visit_sql_block(self, node, visited_children):
        literal, *_ = visited_children
        return literal.text.rstrip()

    def generic_visit(self, node, visited_children):
        return visited_children or node


class Parser(object):
    grammar = Grammar(
        r"""
        expression = _ (block / field)*
        block = field_type field_name "{" expression "}" _
        field = field_type (quoted_literal / sql_block / literal)
        field_type = ~r"[a-z_]+" ":" _
        field_name = ~r"[a-z_]+" _
        quoted_literal = '"' ~"[^\"]+" '"' _
        literal = ("yes" / "no") _
        sql_block = ~"[^;]+" ";;" _
        whitespace = ~r"\s+"
        _ = whitespace*
    """
    )

    def __init__(self, text):
        self.text = text
        self.tree = None

    def build_tree(self, text):
        tree = self.grammar.parse(text)
        return tree

    def parse(self):
        visitor = LookMlVisitor()
        self.tree = self.build_tree(self.text)
        result = visitor.visit(self.tree)
        logging.info(result)
        return result
