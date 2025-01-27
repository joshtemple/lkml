"""Defines constant sequences of LookML keys and helper methods."""

from typing import Dict, Tuple, Type

from lkml import tokens

# These are repeatable keys in LookML that the parser should collapse into a single
# Python dictionary key. For example, LookML can have multiple dimensions, so the parser
# will combine those dimensions into a list of dictionaries with a top-level key,
# `dimensions`.

PLURAL_KEYS: Tuple[str, ...] = (
    "access_filter",
    "access_grant",
    "action",
    "aggregate_table",
    "allowed_value",
    "assert",
    "bind_filters",
    "column",
    "constant",
    "datagroup",
    "remote_dependency",
    "local_dependency",
    "derived_column",
    "dimension",
    "dimension_group",
    "explore",
    "extends",
    "filter",
    "filters",
    "form_param",
    "include",
    "join",
    "link",
    "map_layer",
    "measure",
    "named_value_format",
    "option",
    "override_constant",
    "param",
    "parameter",
    "query",
    "set",
    "sql_step",
    "test",
    "user_attribute_param",
    "view",
    "when",
)

# These are keys in LookML that should be recognized as expression blocks (end with ;;).

EXPR_BLOCK_KEYS: Tuple[str, ...] = (
    "expression_custom_filter",
    "expression",
    "html",
    "sql_trigger_value",
    "sql_table_name",
    "sql_distinct_key",
    "sql_start",
    "sql_always_having",
    "sql_always_where",
    "sql_trigger",
    "sql_foreign_key",
    "sql_where",
    "sql_end",
    "sql_create",
    "sql_latitude",
    "sql_longitude",
    "sql_step",
    "sql_on",
    "sql",
    "sql_preamble",
)

# These are keys that the serializer should quote the value of (e.g. `label: "Label"`).
# An example of an unquoted literal would be `hidden: no`.

QUOTED_LITERAL_KEYS: Tuple[str, ...] = (
    "label",
    "view_label",
    "group_label",
    "group_item_label",
    "suggest_persist_for",
    "default_value",
    "direction",
    "value_format",
    "name",
    "url",
    "icon_url",
    "form_url",
    "default",
    "tags",
    "value",
    "description",
    "sortkeys",
    "indexes",
    "partition_keys",
    "connection",
    "include",
    "max_cache_age",
    "allowed_values",
    "timezone",
    "persist_for",
    "cluster_keys",
    "distribution",
    "extents_json_url",
    "feature_key",
    "file",
    "property_key",
    "property_label_key",
    "else",
    "interval_trigger",
)

# These are keys for fields in Looker that have a "name" attribute. Since lkml uses the
# key `name` to represent the name of the field (e.g. for `dimension: dimension_name {`,
# the `name` key would hold the value `dimension_name`.)

KEYS_WITH_NAME_FIELDS: Tuple[str, ...] = (
    "user_attribute_param",
    "param",
    "form_param",
    "option",
)

CHARACTER_TO_TOKEN: Dict[str, Type[tokens.Token]] = {
    "\0": tokens.StreamEndToken,
    "{": tokens.BlockStartToken,
    "}": tokens.BlockEndToken,
    "[": tokens.ListStartToken,
    "]": tokens.ListEndToken,
    ",": tokens.CommaToken,
    ":": tokens.ValueToken,
    ";": tokens.ExpressionBlockEndToken,
}


def pluralize(key: str) -> str:
    """Converts a singular key like "explore" to a plural key, e.g. 'explores'."""
    if key in ("filters", "bind_filters", "extends"):
        return key + "__all"
    elif key == "query":
        return "queries"
    elif key == "remote_dependency":
        return "remote_dependencies"
    elif key == "local_dependency":
        return "local_dependencies"
    else:
        return key + "s"


def singularize(key: str) -> str:
    """Converts a plural key like "explores" to a singular key, e.g. 'explore'."""
    if key == "queries":
        return "query"
    elif key == "remote_dependencies":
        return "remote_dependency"
    elif key == "local_dependencies":
        return "local_dependency"
    elif key.endswith("__all"):
        return key[:-5]  # Strip off __all
    elif key.endswith("s"):
        return key.rstrip("s")
    else:
        return key
