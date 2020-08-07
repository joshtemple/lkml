import logging
from typing import Union, List, Dict, Any
from lkml.tree import (
    ContainerNode,
    BlockNode,
    ListNode,
    PairNode,
    SyntaxToken,
    SyntaxNode,
    Visitor,
)
from lkml.keys import PLURAL_KEYS

logger = logging.getLogger(__name__)


class BasicVisitor(Visitor):
    @staticmethod
    def _visit(node: Union[SyntaxNode, SyntaxToken]):
        raise NotImplementedError

    def visit_container(self, node: ContainerNode):
        return self._visit(node)

    def visit_block(self, node: BlockNode):
        return self._visit(node)

    def visit_list(self, node: ListNode):
        return self._visit(node)

    def visit_pair(self, node: PairNode):
        return self._visit(node)

    def visit_token(self, token: SyntaxToken):
        return self._visit(token)


class LookMlVisitor(BasicVisitor):
    @staticmethod
    def _visit(node: Union[SyntaxNode, SyntaxToken]) -> str:
        return str(node)


class DictVisitor(Visitor):
    depth: int = 0  # Tracks the level of nesting

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
        
        Examples:
            >>> from pprint import pprint
            >>> parser = Parser((tokens.Token(1),))

            Updating the target with a non-existing, unique key.

            >>> target = {"name": "foo"}
            >>> update = {"sql_table_name": "foo.bar"}
            >>> parser.update_tree(target, update)
            >>> pprint(target)
            {'name': 'foo', 'sql_table_name': 'foo.bar'}

            Updating the target with a non-existing, repeatable key.

            >>> target = {"name": "foo"}
            >>> update = {"dimension": {"sql": "${TABLE}.foo", "name": "foo"}}
            >>> parser.update_tree(target, update)
            >>> pprint(target)
            {'dimensions': [{'name': 'foo', 'sql': '${TABLE}.foo'}], 'name': 'foo'}

            Updating the target with an existing, repeatable key.

            >>> target = {"name": "foo", "dimensions": [{"sql": "${TABLE}.foo", "name": "foo"}]}
            >>> update = {"dimension": {"sql": "${TABLE}.bar", "name": "bar"}}
            >>> parser.update_tree(target, update)
            >>> pprint(target)
            {'dimensions': [{'name': 'foo', 'sql': '${TABLE}.foo'},
                            {'name': 'bar', 'sql': '${TABLE}.bar'}],
             'name': 'foo'}

        """
        keys = tuple(update.keys())
        if len(keys) > 1:
            raise KeyError("Dictionary to update with cannot have multiple keys.")
        key = keys[0]
        stripped_key = key.rstrip("s")
        if stripped_key in PLURAL_KEYS:
            plural_key = stripped_key + "s"
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

    def visit_container(self, node: ContainerNode) -> Dict[str, Any]:
        container = {}
        if len(node.items) > 0:
            self.depth += 1
            for item in node.items:
                self.update_tree(container, item.accept(self))
        return container

    def visit_block(self, node: BlockNode) -> Dict[str, Dict]:
        container_dict = node.container.accept(self)
        if node.name is not None:
            container_dict["name"] = node.name.accept(self)
        return {node.type.accept(self): container_dict}

    def visit_list(self, node: ListNode) -> Dict[str, List]:
        return {node.type.accept(self): [item.accept(self) for item in node.items]}

    def visit_pair(self, node: PairNode) -> Dict[str, str]:
        return {node.key.accept(self): node.value.accept(self)}

    def visit_token(self, token: SyntaxToken) -> str:
        return str(token.value)
