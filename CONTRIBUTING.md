# Contributing to lkml

## Setting up for local development

Follow [these standard instructions](https://opensource.guide/how-to-contribute/#opening-a-pull-request) to get your project set up for development. In a nutshell, you should:

- Fork the repository
- Clone your fork to your local machine
- Create a new local branch off `master` using the `feature/feature-name` branch naming convention

Once your local repository is set up, develop away on your feature! Double-check that you've included the following:

* Tests in `tests/` for any new code that you introduce
* Google-style docstrings for any new functions, classes, or methods
* Type hints for all `def` input arguments and returned outputs

## Test suite and continuous integration

To run the full test suite locally, you'll need to install Docker. Once Docker is installed, the following command will run the test suite:

```
docker compose --rm test
```

The test suite for `lkml` is defined in `scripts/run_tests.sh` for local testing and `.circleci/config.yml` for CI builds. The test suite runs the following:

* [`pytest`](https://docs.pytest.org/en/latest/) to run unit and functional Python tests
* [`mypy`](http://mypy-lang.org/) to check types
* [`flake8`](http://flake8.pycqa.org/en/latest/) to enforce the Python style guide
* [`bandit`](https://bandit.readthedocs.io/en/latest/) to check for security vulnerabilities
* [`black`](https://black.readthedocs.io/en/stable/) to auto-format Python code
* [`isort`](https://isort.readthedocs.io/en/latest/) to check for import statement order

### Local testing vs. CI builds

When run locally, `black` and `isort` will automatically format code. When run as part of a CI build, they only check for proper formatting and will fail the build if the formatting is incorrect.

## Submitting a pull request

Once you've completed development, testing, docstrings, and type hinting, you're ready to submit a pull request. Create a pull request from the feature branch in your fork to `master` in the main repository.

Reference any relevant issues in your PR. If your PR closes an issue, include it (e.g. "Closes #19") so the issue will be auto-closed when the PR is merged.
