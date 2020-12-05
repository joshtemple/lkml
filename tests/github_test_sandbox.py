import logging
from pathlib import Path
import lkml
from lkml.simple import DictParser, DictVisitor

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)

handler = logging.StreamHandler()
handler.setLevel(logging.WARN)

formatter = logging.Formatter("%(name)s %(levelname)s: %(message)s")

handler.setFormatter(formatter)
logger.addHandler(handler)

path = Path(
    "/Users/joshtemple/repos/lkml/tests/resources/github/CUSTOMER_DEMO.model.lkml"
)

with path.open("r") as file:
    lookml = file.read()

# Load the LookML from file, parsing into a tree
tree = lkml.load(lookml)

# Verify it hasn't changed once converted back to string
assert str(tree) == lookml

# Convert that parsed tree into a lossy dictionary
visitor = DictVisitor()
tree_as_dict = visitor.visit(tree)

# Parse the dictionary into a new tree
parser = DictParser()
new_tree = parser.parse(tree_as_dict)
new_tree_as_str = str(new_tree)

with open("test_file.lkml", "w+") as file:
    file.write(new_tree_as_str)

logging.info("Attempting to parse the dict-parsed tree")

# Verify that the string form of the tree parsed from a dictionary can be re-parsed
lkml.load(new_tree_as_str)
