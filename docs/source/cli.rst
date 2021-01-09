Parsing from the command line
=============================
lkml can also be used as a command-line tool. It accepts a single argument: the path to the LookML file to be parsed. When called from the command line, lkml emits the parsed result as a JSON string:

.. code-block:: bash

   lkml orders.view.lkml

If you would like to save the result to a file, you can pipe the output as follows.

.. code-block:: bash

    lkml path/to/file.view.lkml > path/to/result.json

Parsing in debug mode
---------------------
Providing the ``-v`` or ``--verbose`` argument at the command line turns on debug, or verbose mode. In debug mode, lkml will emit its attempts to parse each bit of the LookML string (called a token).

Here's an example of the output:

.. code-block:: bash

    lkml -v orders.view.lkml

    lkml.parser DEBUG: Check StreamStartToken() == StreamStartToken
    lkml.parser DEBUG: Check LiteralToken(view) == CommentToken or WhitespaceToken
    lkml.parser DEBUG: Try to parse [expression] = (block / pair / list)*
    lkml.parser DEBUG: . Check LiteralToken(view) == CommentToken or WhitespaceToken
    lkml.parser DEBUG: . Check LiteralToken(view) == StreamEndToken or BlockEndToken
    lkml.parser DEBUG: . Try to parse [block] = key literal? '{' expression '}'
    lkml.parser DEBUG: . . Try to parse [key] = literal ':'
    lkml.parser DEBUG: . . . Check LiteralToken(view) == CommentToken or WhitespaceToken
    lkml.parser DEBUG: . . . Check LiteralToken(view) == LiteralToken
    lkml.parser DEBUG: . . . Check ValueToken() == CommentToken or WhitespaceToken
    lkml.parser DEBUG: . . . Check ValueToken() == ValueToken
    lkml.parser DEBUG: . . . Check WhitespaceToken(' ') == CommentToken or WhitespaceToken
    lkml.parser DEBUG: . . . Check LiteralToken(view_name) == CommentToken or WhitespaceToken
    lkml.parser DEBUG: . . Successfully parsed key.

lkml iterates through each token in the input and attempts to match it to a line of **grammar**. If lkml tries all known grammar options and doesn't find a match, it will throw a syntax error and exit.

Debug mode helps you understand what lkml is expecting in the input and why it wasn't matched.
