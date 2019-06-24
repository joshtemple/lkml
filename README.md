# lkml

A blazing fast LookML parser implemented in pure Python.

## How do I install it?

lkml is a currently a WIP project. When it's finished, it will be available to install on pip via the following command:

```
pip install lkml
```

## What does the parsed LookML look like?

`lkml` returns the parsed LookML as a Python dictionary.

LookML parameters that can be repeated, like `dimension` or `view`, are collected into lists.

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
     SqlBlockToken(${TABLE}.order_date),
     SqlBlockEndToken()
 )
 ```

 The parser scans through the stream of tokens. It attempts to identify productions in the grammar, descending recursively through a production looking for a match.

 If it doesn't find a match, it backtracks to a previously marked point in the stream and tries a different production. If the parser runs out of productions to try, it raises a syntax error.
