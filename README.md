[![CircleCI](https://img.shields.io/circleci/build/github/joshtemple/lkml.svg)](https://circleci.com/gh/joshtemple/lkml)
[![Codecov](https://img.shields.io/codecov/c/github/joshtemple/lkml.svg)](https://codecov.io/gh/joshtemple/lkml)

# lkml

A blazing fast LookML parser implemented in pure Python.

Why should you use it?
- Tested on **over 160K lines of LookML** from public repositories on GitHub
- Parses a typical view or model file in < **15 ms**
- Written in pure, modern Python 3.7 with **no external dependencies**
- A **full unit test suite** with excellent coverage

## How do I install it?

`lkml` is a currently a WIP project. When it's finished, it will be available to install on pip via the following command:

```
pip install lkml
```

## How do I run it?

You can run `lkml` from the command line or import it as a Python package.

**From the command line**, `lkml` accepts a single positional argument: the path to the LookML file you wish to parse. It returns the parsed result to the console as a JSON string.

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

**As a Python package**, `lkml` uses a similar interface as the `json` and `yaml` packages. The package has a single function, `load`, which accepts a file object and returns a dictionary with the parsed result.

Here's an example:

```python
import lkml

with open('path/to/file.view.lkml', 'r') as file:
    result = lkml.load(file)
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

`lkml` is made up of two main components, a [lexer](https://en.wikipedia.org/wiki/Lexical_analysis) and a parser. The parser is a [recursive descent parser](https://en.wikipedia.org/wiki/Recursive_descent_parser) with backtracking.

The lexer scans through the input string character by character and generates a stream of relevant tokens. The lexer skips over whitespace when it's not relevant.

For example, the input string:

```
"sql: ${TABLE}.order_date ;;"
```

would be broken into the tuple:

 ```
 (
     LiteralToken(sql),
     ValueToken(),
     ExpressionBlockToken(${TABLE}.order_date),
     ExpressionBlockEndToken()
 )
 ```

 The parser scans through the stream of tokens. It attempts to identify productions in the grammar, descending recursively through a production looking for a match.

 If it doesn't find a match, it backtracks to a previously marked point in the stream and tries a different production. If the parser runs out of productions to try, it raises a syntax error.

## TODO:

- [x] Implement models and explores
- [x] Add CI for mypy and pytest
- [x] Add repo badges
- [x] Test with code comments
- [x] Adjust dimensions, measures, etc. to be dicts instead of lists
- [x] Test with funky derived table syntax
- [x] Support HTML blocks
- [x] Support CLI invocation
- [x] Support value formats with escaped quotes
- [x] Support blank lists
- [ ] Improve error handling to return the location of the syntax error
- [x] Test with more LookML, consider GitHub for a larger sample
- [x] Improve debug logging and add a command line flag
- [ ] Performance benchmarking and profiling
- [ ] Reach 100% coverage for `parser.py` and `lexer.py`
- [ ] Implement checking for scanning literals to make sure they're valid
- [ ] Handle plural keys outside of blocks
- [ ] Add docstrings
- [ ] Support parsing from a Unicode string instead of a file
