"""Tests open-source LookML files from GitHub to catch edge cases.

Tests in this file depend on the presence of .lkml files downloaded to the lkml/github
directory. To download these files freshly, you'll need a GitHub API token. Then, run
the script in scripts/ to download the latest batch of public LookML from GitHub.

"""

import itertools
from pathlib import Path
import pytest
import lkml

BASE_GITHUB_PATH = Path(__file__).parents[1] / "github"
# Define this separately so the parameterized fixture suffixes display nicely
filenames = (path.name for path in BASE_GITHUB_PATH.glob("*.lkml"))
FIRST_N_FILES = 100


@pytest.fixture(scope="module", params=itertools.islice(filenames, FIRST_N_FILES))
def lookml(request):
    with (BASE_GITHUB_PATH / request.param).open("r") as file:
        text = file.read()
    yield text


def test_load_should_work(lookml):
    tree = lkml.load(lookml)
    assert str(tree) == lookml
