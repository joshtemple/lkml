[![CircleCI](https://img.shields.io/circleci/build/github/joshtemple/lkml.svg)](https://circleci.com/gh/joshtemple/lkml)
[![Codecov](https://img.shields.io/codecov/c/github/joshtemple/lkml.svg)](https://codecov.io/gh/joshtemple/lkml)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Read the Docs](https://img.shields.io/readthedocs/lkml)](https://lkml.readthedocs.io/en/latest/)

# lkml

A speedy LookML parser and serializer implemented in pure Python.

**Read the documentation on [Read the Docs](https://lkml.readthedocs.io/en/latest/).**

`lkml.load` parses LookML strings to Python objects or JSON strings. `lkml.dump` serializes (generates) LookML strings from Python objects.

Why should you use `lkml`?
- Tested on **over 160K lines of LookML** from public repositories on GitHub
- Parses a typical view or model file in < **10 ms** (excludes I/O time)
- Written in pure, modern Python 3.7 with **no external dependencies**
- A **full unit test suite** with excellent coverage

Interested in contributing to `lkml`? Check out the [contributor guidelines](CONTRIBUTING.md).

## How do I install it?

`lkml` is available to install on [pip](https://pypi.org/project/lkml/) via the following command:

```
pip install lkml
```

