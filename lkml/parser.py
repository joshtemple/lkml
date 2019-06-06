from parsimonious.grammar import Grammar


def load(filename):
    with open(filename, "r") as file:
        lookml = file.read()

    parser = Parser(lookml)
    return parser.parse()


class Parser(object):
    grammar = Grammar(
        """
        block = block_type ":" block_name "{" block* "}"
        block_type = "model" / "view"
        block_name = ~r"[a-z_]+"
    """
    )

    def __init__(self, text):
        self.text = text

    def parse(self):
        return self.grammar.parse(self.text)
