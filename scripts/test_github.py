import logging
import shutil
from pathlib import Path

import lkml

logging.basicConfig(level=logging.INFO)


def test_file(path: Path):
    with path.open("r") as file:
        text = file.read()

    try:
        parsed = lkml.load(text)
    except Exception:
        shutil.copy(path, github_path / "load_errors" / path.name)
        logging.exception(f"Error parsing {path}")

    # try:
    #     dumped = lkml.dump(parsed)
    #     lkml.load(dumped)
    # except Exception:
    #     with open(github_path / "dump_errors" / path.name, "w+") as file:
    #         file.write(dumped)
    #     logging.exception(f"Error serializing {path}")


if __name__ == "__main__":
    github_path = Path(__file__).resolve().parent.parent / "github"

    logging.info("Deleting and recreating error directories")
    for dirname in ["load_errors", "dump_errors"]:
        path = github_path / dirname
        if path.exists():
            shutil.rmtree(path)
        path.mkdir()

    logging.info("Parsing and serializing LookML from...")
    for path in github_path.glob("*.lkml"):
        logging.info(path)
        test_file(path)
