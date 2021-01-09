
Simple LookML parsing
=====================
Parsing a LookML string into Python is easy. Pass the LookML string into :py:func:`lkml.load`.

.. doctest::

   >>> import lkml
   >>> from pprint import pprint

   >>> lookml = """
   ... dimension: order_id {
   ...   sql: ${TABLE}.order_id ;;
   ... }
   ...
   ... dimension_group: created {
   ...   group_label: "Order Date"
   ...   type: time
   ...   timeframes: [hour, date, week, month, year]
   ...   sql: ${TABLE}.created_at ;;
   ... }
   ... 
   ... """

   >>> result = lkml.load(lookml)
   >>> pprint(result)
   {'dimension_groups': [{'group_label': 'Order Date',
                          'name': 'created',
                          'sql': ' ${TABLE}.created_at ',
                          'timeframes': ['hour', 'date', 'week', 'month', 'year'],
                          'type': 'time'}],
    'dimensions': [{'name': 'order_id', 'sql': ' ${TABLE}.order_id '}]}

:py:func:`lkml.load` also supports parsing LookML directly from files::

   with open('orders.view.lkml', 'r') as file:
      result = lkml.load(file)

How LookML is represented by lkml
---------------------------------
When using :py:func:`lkml.load`, LookML is parsed into a JSON-like, nested dictionary format. From here on, we'll refer to LookML field names (e.g. ``sql_table_name``, ``view``, or ``join``) as **keys**.

Blocks with keys like ``dimension`` and ``view`` become dictionaries. lkml adds a key called ``name`` if the block has a name, like the name of the dimension or view.

.. doctest::

   >>> lookml = """
   ... dimension: order_id { hidden: yes }
   ... """

   >>> result = lkml.load(lookml)
   >>> pprint(result)
   {'dimensions': [{'hidden': 'yes', 'name': 'order_id'}]}

Keys with literal or quoted values like ``hidden: yes`` become keys and values in their parent dictionary: ``{"hidden": "yes"}``

Fields that can be repeated (e.g. ``view``, ``dimension``, or ``join``) are combined into a list:

.. doctest::

   >>> lookml = """
   ... dimension: order_id { sql: ${TABLE}.order_id ;; }
   ... dimension: amount { sql: ${TABLE}.amount ;; }
   ... dimension: status { sql: ${TABLE}.status ;; }
   ... """

   >>> result = lkml.load(lookml)
   >>> pprint(result)
   {'dimensions': [{'name': 'order_id', 'sql': ' ${TABLE}.order_id '},
                   {'name': 'amount', 'sql': ' ${TABLE}.amount '},
                   {'name': 'status', 'sql': ' ${TABLE}.status '}]}

Here's an example of some LookML that has been parsed into a dictionary. Note that the repeated key ``join`` has been transformed into a plural key ``joins``: a list of dictionaries representing each join::

   {
      "connection": "bigquery",
      "explores": [
         {
            "label": "Explore",
            "joins": [
               {
                  "relationship": "one_to_many",
                  "type": "inner",
                  "sql_on": "${orders.order_id} = ${order_items.order_id}",
                  "name": "order_items"
               },
               {
                  "relationship": "one_to_one",
                  "type": "inner",
                  "sql_on": "${orders.order_id} = ${orders__extra.order_id}",
                  "name": "orders__extra"
               }
            ],
            "name": "orders"
         },
      ]
   }

.. NOTE::
   Simple parsing will not retain any comments in the LookML. For round-trip parsing that preserves comments and whitespace, see the section on advanced parsing below.

Simple LookML generation
------------------------
It's also possible to generate LookML strings from Python objects using :py:func:`lkml.dump`:

.. doctest::

   >>> lookml = {
   ...     "includes": ["*.view"],
   ...     "explores": [
   ...         {
   ...             "label": "Orders, Items and Users",
   ...             "view_name": "order_items",
   ...             "joins": [
   ...                 {
   ...                     "view_label": "Orders",
   ...                     "relationship": "many_to_one",
   ...                     "sql_on": "${order_facts.order_id} = ${order_items.order_id} ",
   ...                     "name": "order_facts",
   ...                 }
   ...             ],
   ...             "name": "order_items",
   ...         }
   ...     ],
   ... }

   >>> print(lkml.dump(lookml))
   include: "*.view"
   <BLANKLINE>
   explore: order_items {
     label: "Orders, Items and Users"
     view_name: order_items
   <BLANKLINE>
     join: order_facts {
       view_label: "Orders"
       relationship: many_to_one
       sql_on: ${order_facts.order_id} = ${order_items.order_id} ;;
     }
   }

:py:func:`lkml.dump` follows best practices for formatting the generated LookML. Formatting is not currently configurable. For more control over formatting and whitespace, read :doc:`advanced`.

.. WARNING::
   lkml does not validate the LookML it generates. :py:func:`lkml.dump`'s only standard is that the serialized output could be successfully parsed by :py:func:`lkml.load`. It's entirely possible to generate invalid LookML if the input is malformed.

When generating LookML, lkml descends through the dictionary, writing LookML based on the **keys and values** it finds.

* **If the value is a dictionary**, lkml creates a block. Dictionaries can have an optional key called ``name`` (in this case, the name of this dimension is ``price``), as well as a number of key/value pairs. To name a block, include the ``name`` key in the dictionary to be serialized. Here's an example of a dictionary we might provide to :py:func:`lkml.dump`::

    {
        "dimension": {
            "type": "number",
            "label": "Unit Price",
            "sql": "${TABLE}.price",
            "name": "price"
        }
    }

  And here's the resulting block of LookML that is generated:

  .. code-block::

    dimension: price {
        type: number
        label: "Unit Price"
        sql: ${TABLE}.price ;;
    }

* **If the value is a list**, lkml checks the key against a list of known repeatable keys. In the example above, we used a nested dictionary to represent a dimension block. However, LookML allows multiple blocks with the same key (e.g. ``dimension``, ``view``, ``set``, etc.). Since Python dictionaries cannot have duplicate keys, we represent these repeated keys in our dictionary as a single key/value pair, where the key is a pluralized version of the original key (``dimensions`` instead of ``dimension``), and the value is a list of objects that represent each individual field.

  For example, multiple joins on an explore should be represented as follows::

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

  If the key is _not_ in the list of known repeated keys, ``lkml`` creates a list. Here's an example of a list in LookML.

  .. code-block::
  
    fields: [orders.price, orders.ordered_date, orders.order_id]

* **If the value is a string**, lkml creates a quoted or unquoted string based on the key. For example, the value for ``label`` would be quoted, but the value for ``hidden`` would not. Values with keys like ``sql_table_name`` or ``html`` that indicate an expression automatically have a trailing space and ``;;`` appended.

Let's say we've parsed the example view from **"Parsing LookML in Python"** above. We've parsed it into a dictionary and now we want to modify it. We want to change the `type` of the dimension `order_id` from `number` to `string`. Using `lkml`, it's easy to modify the value of `type` in Python and dump it to LookML.

First, we'll modify the value of `type` in the parsed dictionary::

    parsed['views'][0]['dimensions'][0]['type'] = 'string'

Next, we'll dump the dictionary back to LookML in a new file::

    with open('path/to/new.view.lkml', 'w+') as file:
        lkml.dump(parsed, file)

Here's the output.

.. code-block::

  view: {
    sql_table_name: analytics.orders ;;

    dimension: order_id {
      primary_key: yes
      type: string
      sql: ${TABLE}.order_id ;;
    }
  }
