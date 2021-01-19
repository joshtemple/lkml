"""Tests open-source LookML files from GitHub to catch edge cases.

Tests in this file depend on the presence of .lkml files downloaded to the /github
directory. To download these files freshly, you'll need a GitHub API token. Then, run
the script in /scripts to download the latest batch of public LookML from GitHub.

"""

from lkml.simple import DictParser, DictVisitor
from pathlib import Path
import pytest
import lkml

BASE_GITHUB_PATH = Path(__file__).parent / "resources/github"
# Define this separately so the parameterized fixture suffixes display nicely
filenames = (path.name for path in BASE_GITHUB_PATH.glob("*.lkml"))


@pytest.fixture(scope="module", params=filenames)
def lookml(request):
    with (BASE_GITHUB_PATH / request.param).open("r") as file:
        text = file.read()
    yield text


@pytest.mark.acceptance
def test_round_trip_should_work(lookml):
    # Load the LookML from file, parsing into a tree
    tree = lkml.parse(lookml)

    # Verify it hasn't changed once converted back to string
    assert str(tree) == lookml

    # Convert that parsed tree into a lossy dictionary
    visitor = DictVisitor()
    tree_as_dict = visitor.visit(tree)

    # Parse the dictionary into a new tree
    parser = DictParser()
    new_tree = parser.parse(tree_as_dict)

    # Verify that the string form of the tree parsed from a dictionary can be re-parsed
    lkml.load(str(new_tree))
