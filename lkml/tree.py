from __future__ import annotations
from typing import List, Tuple, Optional, Union
from abc import ABC, abstractmethod
from dataclasses import dataclass


@dataclass
class SyntaxToken:
    value: str
    prefix: Optional[str] = None
    suffix: Optional[str] = None

    def format_value(self) -> str:
        return self.value

    def __str__(self) -> str:
        return (self.prefix or "") + self.format_value() + (self.suffix or "")


class QuotedSyntaxToken(SyntaxToken):
    def format_value(self) -> str:
        return '"' + self.value + '"'


class ExpressionSyntaxToken(SyntaxToken):
    def format_value(self) -> str:
        return self.value + " ;;"


class SyntaxNode(ABC):
    @property
    @abstractmethod
    def children(self) -> Optional[Tuple[SyntaxNode]]:
        ...

    @abstractmethod
    def accept(self, visitor: Visitor):
        ...


@dataclass
class PairNode(SyntaxNode):
    key: SyntaxToken
    value: SyntaxToken

    @property
    def children(self) -> None:
        return None

    def accept(self, visitor: Visitor) -> None:
        visitor.visit_pair(self)

    def __str__(self) -> str:
        return str(self.key) + ":" + str(self.value)


@dataclass
class ListNode(SyntaxNode):
    type: SyntaxToken
    items: Union[Tuple[PairNode], Tuple[SyntaxToken]]
    name: Optional[SyntaxToken] = None

    @property
    def children(self) -> Optional[Tuple[PairNode]]:
        return self.items if isinstance(self.items[0], PairNode) else None

    def accept(self, visitor: Visitor) -> None:
        for token in (self.type, self.name):
            if token is not None:
                visitor.visit_token(token)
        for item in self.items:
            if isinstance(item, PairNode):
                visitor.visit_pair(item)
            else:
                visitor.visit_token(item)

    def __str__(self) -> str:
        name = self.name or ""
        return "%s:%s[%s]" % (
            self.type,
            name,
            ",".join(str(item) for item in self.items),
        )


@dataclass
class BlockNode(SyntaxNode):
    type: SyntaxToken
    expression: Optional[ExpressionNode] = None
    name: Optional[SyntaxToken] = None

    @property
    def children(self) -> Optional[Tuple[ExpressionNode]]:
        return (self.expression,) if self.expression else None

    def accept(self, visitor: Visitor) -> None:
        for token in (self.type, self.name):
            if token is not None:
                visitor.visit_token(token)
        if self.expression:
            visitor.visit_expression(self.expression)

    def __str__(self) -> str:
        name = self.name or ""
        expression = str(self.expression) if self.expression else ""
        return "%s:%s{%s}" % (self.type, name, expression)


@dataclass
class ExpressionNode(SyntaxNode):
    items: Tuple[Union[BlockNode, PairNode, ListNode]]

    @property
    def children(self) -> Tuple[Union[BlockNode, PairNode, ListNode]]:
        return self.items

    def accept(self, visitor: Visitor) -> None:
        if self.children:
            for child in self.children:
                if isinstance(child, BlockNode):
                    visitor.visit_block(child)
                elif isinstance(child, PairNode):
                    visitor.visit_pair(child)
                elif isinstance(child, ListNode):
                    visitor.visit_list(child)

    def __str__(self) -> str:
        # TODO: This produces unparseable LookML for unquoted pair values if no suffix
        # For example, hidden: yes + dimension: ... with no whitespace in between
        return "".join(str(item) for item in self.items)


class Visitor(ABC):
    @abstractmethod
    def visit_expression(self, node: ExpressionNode):
        ...

    @abstractmethod
    def visit_block(self, node: BlockNode):
        ...

    @abstractmethod
    def visit_list(self, node: ListNode):
        ...

    @abstractmethod
    def visit_pair(self, node: PairNode):
        ...

    @abstractmethod
    def visit_token(self, token: SyntaxToken):
        ...


class BasicVisitor(Visitor):
    @staticmethod
    def visit(node: SyntaxNode):
        raise NotImplementedError

    def visit_expression(self, node: ExpressionNode):
        return self.visit(node)

    def visit_block(self, node: BlockNode):
        return self.visit(node)

    def visit_list(self, node: ListNode):
        return self.visit(node)

    def visit_pair(self, node: PairNode):
        return self.visit(node)

    def visit_token(self, token: SyntaxToken):
        return self.visit(token)


class LookMlVisitor(BasicVisitor):
    @staticmethod
    def visit(node: SyntaxNode) -> str:
        return str(node)
