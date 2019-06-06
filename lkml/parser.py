from parsimonious.grammar import Grammar


def load(filename):
    with open(filename, "r") as file:
        lookml = file.read()

    parser = Parser(lookml)
    return parser.parse()


class Parser(object):
    grammar = Grammar(
        r"""
        expr = (block / field / ws)*
        block = block_type ":" ws block_name ws "{" expr "}"
        block_type = "model" / "view" / "dimension"
        block_name = field_name
        field = field_name ":" ws quoted
        field_name = ~r"[a-z_]+"
        quoted = ~'"[^\"]+"'
        whitespace = ~r"\s+"
        ws = whitespace
    """
    )

    def __init__(self, text):
        self.text = text

    def parse(self):
        return self.grammar.parse(self.text)
