from pathlib import Path
import logging
import shutil
import lkml

logging.basicConfig(level=logging.INFO)


if __name__ == "__main__":
    github_path = Path(__file__).resolve().parent.parent / "github"
    logging.info("Deleting and recreating github/errored")
    errored_path = github_path / "errored"
    shutil.rmtree(errored_path)
    errored_path.mkdir()

    logging.info("Parsing and serializing LookML from...")
    for path in github_path.glob("*.lkml"):
        logging.info(path)
        with path.open("r") as file:
            text = file.read()
        try:
            parsed = lkml.load(text)
            dumped = lkml.dump(parsed)
        except Exception:
            shutil.copy(path, github_path / "errored" / path.name)
            logging.exception(f"Error parsing or serializing {path}")
