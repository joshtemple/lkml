[![CircleCI](https://img.shields.io/circleci/build/github/joshtemple/lkml.svg)](https://circleci.com/gh/joshtemple/lkml)
[![Codecov](https://img.shields.io/codecov/c/github/joshtemple/lkml.svg)](https://codecov.io/gh/joshtemple/lkml)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

# lkml

A speedy LookML parser and serializer implemented in pure Python.

`lkml.load` parses LookML strings to Python objects or JSON strings. `lkml.dump` serializes (generates) LookML strings from Python objects.

Why should you use `lkml`?
- Tested on **over 160K lines of LookML** from public repositories on GitHub
- Parses a typical view or model file in < **10 ms** (excludes I/O time)
- Written in pure, modern Python 3.7 with **no external dependencies**
- A **full unit test suite** with excellent coverage

## How do I install it?

`lkml` is available to install on [pip](https://pypi.org/project/lkml/) via the following command:

```
pip install lkml
```

## How do I run it?

You can run `lkml` from the command line or import it as a Python package.

#### As a Python package (parsing and serializing)

`lkml` uses a similar interface as the `json` and `yaml` Python packages. The package has two functions:
 - `load`, which accepts a file object and returns a dictionary with the parsed result
 - `dump`, which accepts a Python dictionary and an optional file object to write to. If no file object is provided, `dump` returns the serialized string directly.

Here's how you would load LookML, modify it, and dump the modified version to a new LookML file:

```python
import lkml

with open('path/to/file.view.lkml', 'r') as file:
    parsed = lkml.load(file)

parsed['views'][0]['name'] = 'new_view_name'

with open('path/to/new.view.lkml', 'w+') as file:
    lkml.dump(parsed, file)
```

#### From the command line (parsing only)

`lkml` accepts a single positional argument: the path to the LookML file you wish to parse. It returns the parsed result to the console as a JSON string.

Here's an example:

```bash
lkml path/to/file.view.lkml
```

If you would like to save the result to a file, use the following approach:

```bash
lkml path/to/file.view.lkml > path/to/result.json
```

When running from the command line, pass the debug flag (`-d` or `--debug`) to observe how the parser is attempting to navigate and parse the file.

```bash
lkml path/to/file.view.lkml --debug
```

The debug statements indicate how the parser is descending through the LookML, expecting certain grammar (e.g. `[pair] = key value`), and checking tokens against the expected grammar.

```
lkml.parser . Try to parse [pair] = key value
lkml.parser . . Try to parse [key] = literal ':'
lkml.parser . . . Check LiteralToken(type) == LiteralToken
lkml.parser . . . Check ValueToken() == ValueToken
lkml.parser . . Successfully parsed key.
lkml.parser . . Try to parse [value] = literal / quoted_literal / expression_block
lkml.parser . . . Check LiteralToken(full_outer) == QuotedLiteralToken or LiteralToken
lkml.parser . . Successfully parsed value.
lkml.parser . Successfully parsed pair.
```

## What does the parsed LookML look like?

**From the command line**, `lkml` returns the parsed result as a JSON string. **As a Python package**, `lkml` returns a dictionary with the parsed result.

A number of LookML parameters can be repeated, like `dimension`, `include`, or `view`. `lkml` collects these parameters into lists with a plural key (e.g. `dimensions`).

```json
{
  "connection": "connection_name",
  "explores": [
    {
      "label": "Explore",
      "joins": [
        {
          "relationship": "many_to_one",
          "type": "inner",
          "sql_on": "${view_one.dimension} = ${view_two.dimension}",
          "name": "view_two"
        },
        {
          "relationship": "one_to_many",
          "type": "inner",
          "sql_on": "${view_one.dimension} = ${view_three.dimension}",
          "name": "view_three"
        }
      ],
      "name": "view_one"
    },
  ]
}
```

## How does it work?

`lkml` is made up of three components, a [lexer](https://en.wikipedia.org/wiki/Lexical_analysis), a parser, and a serializer. The parser is a [recursive descent parser](https://en.wikipedia.org/wiki/Recursive_descent_parser) with backtracking.

First, the lexer scans through the input string character by character and generates a stream of relevant tokens. The lexer skips over whitespace when it's not relevant.

For example, the input string:

```
"sql: ${TABLE}.order_date ;;"
```

would be broken into the tuple of tokens:

 ```
 (
     LiteralToken(sql),
     ValueToken(),
     ExpressionBlockToken(${TABLE}.order_date),
     ExpressionBlockEndToken()
 )
 ```

Next, the parser scans through the stream of tokens. It marks its position in the stream, then attempts to identify a matching rule in the grammar. If the rule is made up of other rules (this is a called a non-terminal), it descends recursively through the constituent rules looking for tokens that match.

If it doesn't find a match for a rule, it backtracks to a previously marked point in the stream and tries the next available rule. If the parser runs out of rules to try, it raises a syntax error.

As the parser finds matches, it adds the relevant token values to its syntax tree, which is eventually returned to the user if the input parses successfully.

To dump LookML to a string, `lkml` calls the serializer, which navigates through the Python dictionary provided, writing out blocks, sets, pairs, keys, and values where needed.

## Testing

This project uses CircleCI as a CI provider.
The code can be tested locally, however, using `docker-compose`.

```bash
docker-compose run --rm test
```

### What does the test suite run?

* [`pytest`](https://docs.pytest.org/en/latest/) for unit testing
* [`mypy`](http://mypy-lang.org/) for type checking
* [`flake8`](http://flake8.pycqa.org/en/latest/) for enforcing the Python style guide
* [`bandit`](https://bandit.readthedocs.io/en/latest/) for checking for security vulnerabilities
* [`black`](https://black.readthedocs.io/en/stable/) for code formatting
  * When run locally, the test suite will auto-format the codebase.
  * When run in CircleCI, unformatted code will cause the test suite to fail.
* [`iSort`](https://isort.readthedocs.io/en/latest/) for sorting imports
  * When run locally, the test suite will auto-sort imports in the codebase.
  * When run in CircleCI, unsorted imports will cause the test suite to fail.

### How are the tests configured?

Custom configuration options are set in `setup.cfg`, `pyproject.toml`, or `.bandit`, depending on the config options supported by each tool.
