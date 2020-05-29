from typing import Tuple, Optional, Union
from abc import ABC, abstractmethod
from dataclasses import dataclass


@dataclass
class SyntaxToken:
    value: str
    prefix: Optional[str] = None
    suffix: Optional[str] = None

    @property
    def _value(self) -> str:
        return self.value

    def __str__(self) -> str:
        return (self.prefix or "") + self._value + (self.suffix or "")


class QuotedSyntaxToken(SyntaxToken):
    @property
    def _value(self) -> str:
        return '"' + self.value + '"'


class ExpressionSyntaxToken(SyntaxToken):
    @property
    def _value(self) -> str:
        return self.value + " ;;"


class SyntaxNode(ABC):
    @property
    @abstractmethod
    def children(self) -> Optional[Tuple["SyntaxNode"]]:
        ...


@dataclass
class PairNode(SyntaxNode):
    key: SyntaxToken
    value: SyntaxToken

    @property
    def children(self) -> None:
        return None

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

    def __str__(self) -> str:
        name = "" if self.name is None else self.name
        return "%s:%s[%s]" % (
            self.type,
            name,
            "".join(str(item) for item in self.items),
        )


@dataclass
class BlockNode(SyntaxNode):
    type: SyntaxToken
    pairs: Tuple[PairNode]
    name: Optional[SyntaxToken] = None

    @property
    def children(self) -> Tuple[PairNode]:
        return self.pairs

    def __str__(self) -> str:
        name = "" if self.name is None else self.name
        return "%s:%s{%s}" % (
            self.type,
            name,
            "".join(str(pair) for pair in self.pairs),
        )
