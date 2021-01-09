
Simple LookML parsing
=====================
Parsing a LookML string into Python is easy. Pass the LookML string into ``lkml.load``.

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
                          'sql': '${TABLE}.created_at ',
                          'timeframes': ['hour', 'date', 'week', 'month', 'year'],
                          'type': 'time'}],
    'dimensions': [{'name': 'order_id', 'sql': '${TABLE}.order_id '}]}

``lkml.load`` also supports parsing LookML directly from files::

   with open('orders.view.lkml', 'r') as file:
      result = lkml.load(file)

How LookML is represented by lkml
---------------------------------
When using ``lkml.load``, LookML is parsed into a JSON-like, nested dictionary format. From here on, we'll refer to LookML field names (e.g. ``sql_table_name``, ``view``, or ``join``) as **keys**.

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
   {'dimensions': [{'name': 'order_id', 'sql': '${TABLE}.order_id '},
                   {'name': 'amount', 'sql': '${TABLE}.amount '},
                   {'name': 'status', 'sql': '${TABLE}.status '}]}

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
It's also possible to generate LookML strings from Python objects using ``lkml.dump``:

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

``lkml.dump`` follows best practices for formatting the generated LookML. Formatting is not currently configurable. For more control over formatting and whitespace, read the next section on advanced parsing.
