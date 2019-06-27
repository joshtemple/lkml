[![CircleCI](https://img.shields.io/circleci/build/github/joshtemple/lkml.svg)](https://circleci.com/gh/joshtemple/lkml)
[![Codecov](https://img.shields.io/codecov/c/github/joshtemple/lkml.svg)](https://codecov.io/gh/joshtemple/lkml)

# lkml

A speedy LookML parser implemented in pure Python.

Why should you use it?
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
