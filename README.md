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

Interested in contributing to `lkml`? Check out the [contributor guidelines](CONTRIBUTING.md).

## How do I install it?

`lkml` is available to install on [pip](https://pypi.org/project/lkml/) via the following command:

```
pip install lkml
```

## How do I run it?

You can run `lkml` from the command line (parsing only) or import it as a Python package (parsing and serializing).

`lkml` uses a similar interface as the `json` and `yaml` Python packages. The package has two functions:
 - `load`, which accepts a file object and returns a dictionary with the parsed result
 - `dump`, which accepts a Python dictionary and an optional file object to write to. If no file object is provided, `dump` returns the serialized string directly.

### How does `lkml` represent LookML in Python?

`lkml` represents LookML as a nested dictionary structure in Python. Within this documentation, we'll refer to LookML field names (e.g. `sql_table_name`, `view`, `join`) as **keys**.

During parsing,

* Blocks with keys like `dimension` and `view` become dictionaries. `lkml` adds a key called `name` if the block has a name (e.g. the name of the dimension or view)
* Keys with literal values like `hidden: yes` become keys and values `{"hidden": "yes"}` in their parent dictionaries
* Lists (e.g. `fields`) become lists in their parent dictionaries

A number of LookML keys can be repeated, like `dimension`, `include`, or `view`. `lkml` collects these **repeated keys** into lists with a pluralized key (e.g. `dimension` becomes `dimensions`).

Here's an example of some LookML that has been parsed into a dictionary. Note that the repeated key `join` has been transformed into a plural key `joins`: a list of dictionaries representing each join.

```python
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

### Parsing LookML in Python

Parsing LookML in Python is simple with `lkml`. Imagine the view below.

```lookml
view: view_name {
  sql_table_name: analytics.orders ;;

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }
}
```
`lkml.load` accepts a file object or a LookML string and returns the parsed result as a dictionary. Here we pass it a file object.
```python
import lkml

with open('path/to/file.view.lkml', 'r') as file:
    parsed = lkml.load(file)
```

`load`  returns this dictionary.

```python
{
  "views": [
    {
      "sql_table_name": "analytics.orders",
      "dimensions": [
        {
          "primary_key": "yes",
          "type": "number",
          "sql": "${TABLE}.order_id",
          "name": "order_id",
        }
      ],
      "name": "view_name"
    }
  ]
}
```

Notice how the name of the dimension, `order_id`, is preserved in the `name` key of the first element of the list value of `dimensions`. Similarly, the name of the view is also preserved.


### Serializing (generating) LookML in Python

`lkml.dump` accepts a Python dictionary representing the LookML that you would like to generate. If you pass a file object as an input argument, it will write the serialized result to that file. If not, it returns a LookML string.

`lkml` does not validate the LookML it generates. `lkml.dump`'s only standard is that the serialized output could be successfully parsed by `lkml.load`. It's entirely possible to generate invalid LookML if the input is malformed. For help representing the input object appropriately, see the section on representing LookML in Python above.

`lkml` descends through the dictionary, writing LookML based on the **keys and values** it finds.

* **If the value is a dictionary**, `lkml` creates a block. Dictionaries can have an optional key called `name` (in this case, the name of this dimension is `price`), as well as a number of key/value pairs. To name a block, include the `name` key in the dictionary to be serialized. Here's an example of a dictionary we might provide to `lkml.dump`.

  ```python
  {
    "dimension": {
      "type": "number",
      "label": "Unit Price",
      "sql": "${TABLE}.price",
      "name": "price"
    }
  }
  ```

  And here's the resulting block of LookML that is generated.

  ```lookml
  dimension: price {
    type: number
    label: "Unit Price"
    sql: ${TABLE}.price ;;
  }
  ```

* **If the value is a list**, `lkml` checks the key against a list of known repeatable keys. In the example above, we used a nested dictionary to represent a dimension block. However, LookML allows multiple blocks with the same key (e.g. `dimension`, `view`, `set`, etc.). Since Python dictionaries cannot have duplicate keys, we represent these repeated keys in our dictionary as a single key/value pair, where the key is a pluralized version of the original key (`dimensions` instead of `dimension`), and the value is a list of objects that represent each individual field.

  For example, multiple joins on an explore should be represented as follows.

  ```python
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
  ]
  ```

  If the key is _not_ in the list of known repeated keys, `lkml` creates a list. Here's an example of a list in LookML.

  ```lookml
  fields: [orders.price, orders.ordered_date, orders.order_id]
  ```

* **If the value is a string**, `lkml` creates a quoted or unquoted string based on the key. For example, the value for `label` would be quoted, but the value for `hidden` would not. Values with keys like `sql_table_name` or `html` that indicate an expression automatically have a trailing space and `;;` appended.

Let's say we've parsed the example view from **"Parsing LookML in Python"** above. We've parsed it into a dictionary and now we want to modify it. We want to change the `type` of the dimension `order_id` from `number` to `string`. Using `lkml`, it's easy to modify the value of `type` in Python and dump it to LookML.

First, we'll modify the value of `type` in the parsed dictionary.
```python
parsed['views'][0]['dimensions'][0]['type'] = 'string'
```

Next, we'll dump the dictionary back to LookML in a new file.

```python
with open('path/to/new.view.lkml', 'w+') as file:
    lkml.dump(parsed, file)
```

Here's the output.

```lookml
view: {
  sql_table_name: analytics.orders ;;

  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
  }
}
```

`lkml.dump` does not allow control over the formatting of the serialized LookML and will use my opinionated style for the resulting LookML. If you want to play with the formatting, take a look at the `DictParser` class, which is used to generate a parse tree from the parsed Python dictionary and contains assumptions about how whitespace is generated.

### Parsing LookML from the command line

At the command line, `lkml` accepts a single positional argument: the path to the LookML file to parse. It returns the parsed result to `stdout` as a JSON string.

Here's an example.

```bash
lkml path/to/file.view.lkml
```

If you would like to save the result to a file, you can pipe the output as follows.

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
