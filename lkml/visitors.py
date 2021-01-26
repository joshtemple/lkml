import logging
from dataclasses import replace
from typing import Union, overload

from lkml.tree import (
    BlockNode,
    ContainerNode,
    DocumentNode,
    ListNode,
    PairNode,
    SyntaxNode,
    SyntaxToken,
    Visitor,
)

logger = logging.getLogger(__name__)


class BasicVisitor(Visitor):
    """Visitor class that calls the ``_visit`` method for every node type.

    This class doesn't actually do anything when visiting a tree other than traverse
    the nodes. It's meant to be used as a base class for building more useful and
    complex visitors. For example, override any of the ``visit_`` methods for node-type
    specific behavior.

    """

    def _visit(self, node: Union[SyntaxNode, SyntaxToken]):
        """For each node, visit its children."""
        if isinstance(node, SyntaxToken):
            return
        elif node.children:
            for child in node.children:
                child.accept(self)

    def visit(self, document: DocumentNode):
        return self._visit(document)

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
    """Converts a parse tree into a string by casting every node."""

    @staticmethod
    def _visit(node: Union[SyntaxNode, SyntaxToken]) -> str:
        return str(node)


class BasicTransformer(Visitor):
    """Visitor class that returns a new tree, modifying the tree as needed."""

    @overload
    def _visit_items(self, node: ContainerNode) -> ContainerNode:
        ...

    @overload
    def _visit_items(self, node: ListNode) -> ListNode:
        ...

    def _visit_items(self, node):
        """Visit a node whose children are held in the ``items`` attribute."""
        if node.children:
            new_children = tuple(child.accept(self) for child in node.children)
            return replace(node, items=new_children)
        else:
            return node

    @overload
    def _visit_container(self, node: BlockNode) -> BlockNode:
        ...

    @overload
    def _visit_container(self, node: DocumentNode) -> DocumentNode:
        ...

    def _visit_container(self, node):
        """Visit a node whose only child is the ``container`` attribute."""
        if node.container:
            new_child = node.container.accept(self)
            return replace(node, container=new_child)
        else:
            return node

    def visit(self, node: DocumentNode) -> DocumentNode:
        return self._visit_container(node)

    def visit_container(self, node: ContainerNode) -> ContainerNode:
        return self._visit_items(node)

    def visit_list(self, node: ListNode) -> ListNode:
        return self._visit_items(node)

    def visit_block(self, node: BlockNode) -> BlockNode:
        return self._visit_container(node)

    def visit_pair(self, node: PairNode) -> PairNode:
        return node

    def visit_token(self, token: SyntaxToken) -> SyntaxToken:
        return token
