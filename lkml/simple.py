"""Interface classes between the parse tree and a data structure of primitives.

These classes facilitate parsing and generation to and from simple data structures like
lists and dictionaries, and allow users to parse and generate LookML without needing
to interact with the parse tree.

"""

import logging
from typing import Any, Dict, List, Optional, Sequence, Type, Union, cast

from lkml.keys import (
    EXPR_BLOCK_KEYS,
    KEYS_WITH_NAME_FIELDS,
    PLURAL_KEYS,
    QUOTED_LITERAL_KEYS,
    pluralize,
    singularize,
)
from lkml.tree import (
    BlockNode,
    Comma,
    ContainerNode,
    DocumentNode,
    ExpressionSyntaxToken,
    LeftBracket,
    LeftCurlyBrace,
    ListNode,
    PairNode,
    QuotedSyntaxToken,
    RightBracket,
    RightCurlyBrace,
    SyntaxNode,
    SyntaxToken,
)
from lkml.visitors import Visitor

logger = logging.getLogger(__name__)


def flatten(sequence: list) -> list:
    """Flattens a singly-nested list of lists into a list of items."""
    result = []
    for each in sequence:
        if isinstance(each, list):
            result.extend(each)
        else:
            result.append(each)
    return result


class DictVisitor(Visitor):
    """Creates a primitive representation of the parse tree.

    Traverses the parse tree and transforms each node type into a dict. Each dict is
    combined into one nested dict. Also handles the grouping of fields with plural keys
    like ``dimension`` or ``view`` into lists.

    Attributes:
        depth: Tracks the level of nesting.
    """

    def __init__(self):
        self.depth: int = -1  # Tracks the level of nesting

    def update_tree(self, target: Dict, update: Dict) -> None:
        """Add one dictionary to an existing dictionary, handling certain repeated keys.

        This method is primarily responsible for handling repeated keys in LookML like
        `dimension` or `set`, which can exist more than once in LookML but cannot be
        repeated in a Python dictionary.

        This method checks the list of valid repeated keys and combines the values of
        that key in `target` and/or `update` into a list and assigns a plural key (e.g.
        `dimensions` instead of `dimension`).

        Args:
            target: Existing dictionary of parsed LookML
            update: New dictionary to be added to target

        Raises:
            KeyError: If `update` has more than one key
            KeyError: If the key in `update` already exists and would overwrite existing

        """
        keys = tuple(update.keys())
        if len(keys) > 1:
            raise KeyError("Dictionary to update with cannot have multiple keys.")
        key = keys[0]

        if key in PLURAL_KEYS:
            plural_key = pluralize(key)
            if plural_key in target.keys():
                target[plural_key].append(update[key])
            else:
                target[plural_key] = [update[key]]
        elif key in target.keys():
            if self.depth == 0:
                logger.warning(
                    'Multiple declarations of top-level key "%s" found. '
                    "Using the last-declared value.",
                    key,
                )
                target[key] = update[key]
            else:
                raise KeyError(
                    f'Key "{key}" already exists in tree '
                    "and would overwrite the existing value."
                )
        else:
            target[key] = update[key]

    def visit(self, document: DocumentNode) -> Dict[str, Any]:
        return self.visit_container(document.container)

    def visit_container(self, node: ContainerNode) -> Dict[str, Any]:
        """Creates a dict from a container node by visiting its children."""
        container: Dict[str, Any] = {}
        if len(node.items) > 0:
            self.depth += 1
            for item in node.items:
                self.update_tree(container, item.accept(self))
            self.depth -= 1
        return container

    def visit_block(self, node: BlockNode) -> Dict[str, Dict]:
        """Creates a dict from a block node by visiting its children."""
        container_dict = node.container.accept(self) if node.container else {}
        if node.name is not None:
            container_dict["name"] = node.name.accept(self)
        return {node.type.accept(self): container_dict}

    def visit_list(self, node: ListNode) -> Dict[str, List]:
        """Creates a dict from a list node by visiting its children."""
        return {node.type.accept(self): [item.accept(self) for item in node.items]}

    def visit_pair(self, node: PairNode) -> Dict[str, str]:
        """Creates a dict from pair node by visiting its type and value tokens."""
        return {node.type.accept(self): node.value.accept(self)}

    def visit_token(self, token: SyntaxToken) -> str:
        """Creates a string from a syntax token."""
        return str(token.value)


class DictParser:
    """Parses a Python dictionary into a parse tree.

    Review the grammar specified for the Parser class to understand how LookML
    is represented. The grammar details the differences between blocks, pairs, keys,
    and values.

    Attributes:
        parent_key: The name of the key at the previous level in a LookML block.
        level: The number of indentations appropriate for the current position.
        base_indent: Whitespace representing one tab.
        latest_node: The type of the last node to be parsed.

    """

    def __init__(self):
        self.parent_key: str = None
        self.level: int = 0
        self.base_indent: str = " " * 2
        self.latest_node: Optional[Type[SyntaxNode]] = DocumentNode

    def increase_level(self) -> None:
        """Increases the indent level of the current line by one tab.

        This also resets the latest node, mainly for formatting reasons.

        """
        self.latest_node = None
        self.level += 1

    def decrease_level(self) -> None:
        """Decreases the indent level of the current line by one tab."""
        self.level -= 1

    @property
    def indent(self) -> str:
        """Returns the level-adjusted indent."""
        if self.level > 0:
            return self.base_indent * self.level
        else:
            return ""

    @property
    def newline_indent(self) -> str:
        """Returns a newline plus the current indent."""
        return "\n" + self.indent

    @property
    def prefix(self) -> str:
        """Returns the currently appropriate, preceding whitespace."""
        if self.latest_node == DocumentNode:
            return ""
        elif self.latest_node is None:
            return self.newline_indent
        elif self.latest_node == BlockNode:
            return "\n" + self.newline_indent
        else:
            return self.newline_indent

    def is_plural_key(self, key: str) -> bool:
        """Returns True if the key is a repeatable key.

        For example, `dimension` can be repeated, but `sql` cannot be.

        The key `allowed_value` is a special case and changes behavior depending on its
        parent key. If its parent key is `access_grant`, it is a list and cannot be
        repeated. Otherwise, it can be repeated.

        The parent key `query` is also a special case, where children are kept as lists.
        See issue #53.

        Args:
            key: The name of the key to test.

        """
        singular_key = singularize(key)
        return (
            singular_key in PLURAL_KEYS
            and not (
                singular_key == "allowed_value"
                and self.parent_key.rstrip("s") == "access_grant"
            )
            and not (self.parent_key == "query")
        )

    def resolve_filters(self, values: List[dict]) -> Union[List[BlockNode], ListNode]:
        """Parse the key ``filters`` according to the context.

        In LookML, the ``filters`` key is wildly inconsistent and can have three
        different syntaxes. This method determines the syntax that should be used based
        on the context and parses the appropriate node.

        Args:
            values: The contents of the ``filters`` block. Provides context to resolve.

        Returns:
            A block or list node depending on the resolution.

        """
        if "name" in values[0]:
            # This is one or more filter-only field(s), e.g.
            # filter: order_region { type: string }
            blocks = []
            for value in values:
                name = value.pop("name")
                block = self.parse_block(key="filter", items=value, name=name)
                blocks.append(block)
            return blocks
        elif "field" in values[0] and "value" in values[0]:
            # This is the legacy filter syntax, e.g.
            # filters: { field: dimension_name, value: "filter expression" }
            return [self.parse_block(key="filters", items=value) for value in values]
        else:
            # This is the new filter syntax, e.g.
            # filters: [ dimension_name: "filter expression", ... ]
            return self.parse_list(key="filters", values=values)

    def parse(self, obj: Dict[str, Any]) -> DocumentNode:
        """Parses a primitive representation of LookML into a parse tree."""
        nodes = [self.parse_any(key, value) for key, value in obj.items()]
        container = ContainerNode(items=tuple(flatten(nodes)))
        return DocumentNode(container)

    def expand_list(
        self, key: str, values: Sequence
    ) -> List[Union[BlockNode, ListNode, PairNode]]:
        """Expands and parses a list of values for a repeatable key.

        Args:
            key: A repeatable LookML field type (e.g. "views" or "dimension_groups")
            values: A sequence of objects to be parsed

        Returns:
            A list of block, list, or pair nodes, depending on the list's contents.

        """
        # A dictionary with a key "filters" can correspond to multiple syntaxes, so
        # must be handled in a context-aware manner
        if key == "filters":
            values = cast(List[dict], values)
            return flatten([self.resolve_filters(values)])
        else:
            singular_key = singularize(key)
            return flatten([self.parse_any(singular_key, value) for value in values])

    def parse_any(
        self, key: str, value: Union[str, list, tuple, dict]
    ) -> Union[
        List[Union[BlockNode, ListNode, PairNode]], BlockNode, ListNode, PairNode
    ]:
        """Dynamically serializes a Python object based on its type.

        Args:
            key: A LookML field type (e.g. "suggestions" or "hidden")
            value: A string, tuple, or list to serialize

        Raises:
            TypeError: If input value is not of a valid type

        Returns:
            A generator of serialized string chunks

        """
        if isinstance(value, str):
            return self.parse_pair(key, value)
        elif isinstance(value, (list, tuple)):
            if self.is_plural_key(key):
                return self.expand_list(key, value)
            else:
                return self.parse_list(key, value)
        elif isinstance(value, dict):
            if key in KEYS_WITH_NAME_FIELDS or "name" not in value.keys():
                name = None
            else:
                name = value.pop("name")
            return self.parse_block(key, value, name)
        else:
            raise TypeError("Value must be a string, list, tuple, or dict.")

    def parse_block(
        self, key: str, items: Dict[str, Any], name: Optional[str] = None
    ) -> BlockNode:
        """Serializes a dictionary to a LookML block.

        Args:
            key: A LookML field type (e.g. "dimension")
            fields: A dictionary to serialize (e.g. {"sql": "${TABLE}.order_id"})
            name: An optional name of the block (e.g. "order_id")

        Returns:
            A generator of serialized string chunks

        """
        prev_parent_key = self.parent_key
        self.parent_key = key
        latest_node_at_this_level = self.latest_node
        self.increase_level()
        nodes = [self.parse_any(key, value) for key, value in items.items()]
        self.decrease_level()
        self.latest_node = latest_node_at_this_level
        self.parent_key = prev_parent_key

        container = ContainerNode(items=tuple(flatten(nodes)))

        if self.latest_node and self.latest_node != DocumentNode:
            prefix = "\n" + self.newline_indent
        else:
            prefix = self.prefix

        node = BlockNode(
            type=SyntaxToken(key, prefix=prefix),
            left_brace=LeftCurlyBrace(prefix=" " if name else ""),
            right_brace=RightCurlyBrace(
                prefix=self.newline_indent if container.items else ""
            ),
            name=SyntaxToken(name) if name else None,
            container=container,
        )
        self.latest_node = BlockNode
        return node

    def parse_list(self, key: str, values: Sequence[Union[str, Dict]]) -> ListNode:
        """Serializes a sequence to a LookML block.

        Args:
            key: A LookML field type (e.g. "fields")
            values: A sequence to serialize (e.g. ["orders.order_id", "orders.item"])

        Returns:
            A generator of serialized string chunks

        """
        # `suggestions` is only quoted when it's a list, so override the default
        force_quote = True if key == "suggestions" else False
        prev_parent_key = self.parent_key
        self.parent_key = key

        type_token = SyntaxToken(key, prefix=self.prefix)
        right_bracket = RightBracket()
        items: list = []
        pair_mode = False

        # Check the first element to see if it's a single value or a pair
        if values and not isinstance(values[0], (str, int)):
            pair_mode = True

        # Coerce type depending on pair mode value
        if pair_mode:
            items = cast(List[PairNode], items)
        else:
            items = cast(List[SyntaxToken], items)

        # Choose newline delimiting or space delimiting based on contents
        if len(values) >= 5 or pair_mode:
            trailing_comma: Optional[Comma] = Comma()
            self.increase_level()
            for value in values:
                if pair_mode:
                    value = cast(dict, value)
                    # Extract key and value from dictionary with only one key
                    [(key, val)] = value.items()
                    pair: PairNode = self.parse_pair(key, val)
                    items.append(pair)
                else:
                    value = cast(str, value)
                    token: SyntaxToken = self.parse_token(
                        key, value, force_quote, prefix=self.newline_indent
                    )
                    items.append(token)
            self.decrease_level()
            right_bracket = RightBracket(prefix=self.newline_indent)
        else:
            trailing_comma = None
            for i, value in enumerate(values):
                value = cast(str, value)
                if i == 0:
                    token = self.parse_token(key, value, force_quote)
                else:
                    token = self.parse_token(key, value, force_quote, prefix=" ")
                items.append(token)

        self.parent_key = prev_parent_key

        node = ListNode(
            type=type_token,
            left_bracket=LeftBracket(),
            items=tuple(items),
            right_bracket=right_bracket,
            trailing_comma=trailing_comma,
        )
        self.latest_node = ListNode
        return node

    def parse_pair(self, key: str, value: str) -> PairNode:
        """Serializes a key and value to a LookML pair.

        Args:
            key: A LookML field type (e.g. "hidden")
            value: The value string (e.g. "yes")

        Returns:
            A generator of serialized string chunks

        """
        force_quote = True if self.parent_key == "filters" and key != "field" else False
        value_syntax_token: SyntaxToken = self.parse_token(key, value, force_quote)
        node = PairNode(
            type=SyntaxToken(key, prefix=self.prefix), value=value_syntax_token
        )
        self.latest_node = PairNode
        return node

    @staticmethod
    def parse_token(
        key: str,
        value: str,
        force_quote: bool = False,
        prefix: str = "",
        suffix: str = "",
    ) -> SyntaxToken:
        """Parses a value into a token, quoting it if required by the key or forced.

        Args:
            key: A LookML field type (e.g. "hidden")
            value: The value string (e.g. "yes")
            force_quote: True if value should always be quoted

        Returns:
            A generator of serialized string chunks

        """
        if force_quote or key in QUOTED_LITERAL_KEYS:
            return QuotedSyntaxToken(value, prefix=prefix, suffix=suffix)
        elif key in EXPR_BLOCK_KEYS:
            return ExpressionSyntaxToken(value.strip(), prefix=prefix, suffix=suffix)
        else:
            return SyntaxToken(value, prefix=prefix, suffix=suffix)
