from __future__ import annotations
from typing import Tuple, Optional, Union
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
        if self.children:
            for child in self.children:
                visitor.visit_pair(child)
        else:
            for item in self.items:
                visitor.visit_token(item)

    def __str__(self) -> str:
        name = "" if self.name is None else self.name
        return "%s:%s[%s]" % (
            self.type,
            name,
            ",".join(str(item) for item in self.items),
        )


@dataclass
class BlockNode(SyntaxNode):
    type: SyntaxToken
    pairs: Tuple[PairNode]
    name: Optional[SyntaxToken] = None

    @property
    def children(self) -> Tuple[PairNode]:
        return self.pairs

    def accept(self, visitor: Visitor) -> None:
        for token in (self.type, self.name):
            if token is not None:
                visitor.visit_token(token)
        if self.children:
            for child in self.children:
                visitor.visit_pair(child)

    def __str__(self) -> str:
        name = "" if self.name is None else self.name
        return "%s:%s{%s}" % (
            self.type,
            name,
            "".join(str(pair) for pair in self.pairs),
        )


class Visitor(ABC):
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


class StringifyVisitor(Visitor):
    def visit_block(self, node: BlockNode) -> str:
        return str(node)

    def visit_list(self, node: ListNode) -> str:
        return str(node)

    def visit_pair(self, node: PairNode) -> str:
        return str(node)

    def visit_token(self, token: SyntaxToken) -> str:
        return str(token)
