from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Any, Counter, Optional, Tuple, Union, cast

from lkml.keys import PLURAL_KEYS


def items_to_str(*items: Any) -> str:
    """Converts each item to a string and joins them together"""
    return "".join(str(item) for item in items)


@dataclass
class SyntaxToken:
    value: str
    prefix: Optional[str] = None
    suffix: Optional[str] = None

    def __post_init__(self):
        self.prefix: str = self.prefix or ""
        self.suffix: str = self.suffix or ""

    def format_value(self) -> str:
        return self.value

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_token(self)

    def __str__(self) -> str:
        return items_to_str(self.prefix, self.format_value(), self.suffix)


@dataclass
class LeftCurlyBrace(SyntaxToken):
    value: str = "{"


@dataclass
class RightCurlyBrace(SyntaxToken):
    value: str = "}"


@dataclass
class Colon(SyntaxToken):
    value: str = ":"


@dataclass
class LeftBracket(SyntaxToken):
    value: str = "["


@dataclass
class RightBracket(SyntaxToken):
    value: str = "]"


@dataclass
class DoubleSemicolon(SyntaxToken):
    value: str = ";;"


class QuotedSyntaxToken(SyntaxToken):
    def format_value(self) -> str:
        return '"' + self.value + '"'


class ExpressionSyntaxToken(SyntaxToken):
    def format_value(self) -> str:
        return self.value + ";;"


class SyntaxNode(ABC):
    @property
    @abstractmethod
    def children(self) -> Optional[Tuple[SyntaxNode, ...]]:
        ...

    @abstractmethod
    def accept(self, visitor: Visitor) -> Any:
        ...


@dataclass
class PairNode(SyntaxNode):
    type: SyntaxToken
    value: SyntaxToken
    colon: Optional[Colon] = None

    def __post_init__(self):
        if self.colon is None:
            self.colon = Colon(suffix=" ")

    def __repr__(self) -> str:
        return f"{self.__class__.__name__}({self.type.value}, {self.value.value})"

    @property
    def children(self) -> None:
        return None

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_pair(self)

    def __str__(self) -> str:
        return items_to_str(self.type, self.colon, self.value)


@dataclass
class ListNode(SyntaxNode):
    type: SyntaxToken
    items: Union[Tuple[PairNode, ...], Tuple[SyntaxToken, ...]]
    left_bracket: LeftBracket
    right_bracket: RightBracket
    colon: Optional[Colon] = None
    trailing_comma: bool = False

    def __post_init__(self):
        if self.colon is None:
            self.colon = Colon(suffix=" ")

    def __repr__(self) -> str:
        return f"{self.__class__.__name__}({self.type.value})"

    @property
    def children(self,) -> Optional[Tuple[PairNode, ...]]:
        if isinstance(self.items[0], PairNode):
            # Assume that all elements are pairs
            self.items = cast(Tuple[PairNode, ...], self.items)
            return self.items
        else:
            return None

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_list(self)

    def __str__(self) -> str:
        return items_to_str(
            self.type,
            self.colon,
            self.left_bracket,
            ",".join(str(item) for item in self.items),
            "," if self.trailing_comma and len(self.items) > 0 else "",
            self.right_bracket,
        )


@dataclass
class BlockNode(SyntaxNode):
    type: SyntaxToken
    left_brace: LeftCurlyBrace
    right_brace: RightCurlyBrace
    colon: Optional[Colon] = None
    name: Optional[SyntaxToken] = None
    container: Optional[ContainerNode] = None

    def __post_init__(self):
        if self.colon is None:
            self.colon = Colon(suffix=" ")

    def __repr__(self) -> str:
        name = self.name.value if self.name else None
        return f"{self.__class__.__name__}({self.type.value}, {name})"

    @property
    def children(self) -> Optional[Tuple[ContainerNode, ...]]:
        return (self.container,) if self.container else None

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_block(self)

    def __str__(self) -> str:
        name = self.name or ""
        container = self.container or ""
        return items_to_str(
            self.type, self.colon, name, self.left_brace, container, self.right_brace,
        )


@dataclass
class DocumentNode(SyntaxNode):
    container: ContainerNode
    prefix: str = ""
    suffix: str = ""

    @property
    def children(self) -> Tuple[ContainerNode]:
        return tuple(self.container)  # type: ignore

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit(self)

    def __str__(self) -> str:
        return items_to_str(self.prefix, self.container, self.suffix)


@dataclass
class ContainerNode(SyntaxNode):
    items: Tuple[Union[BlockNode, PairNode, ListNode], ...]
    top_level: bool = False

    def __repr__(self) -> str:
        return f"{self.__class__.__name__}()"

    def __post_init__(self):
        counter = Counter(item.type.value for item in self.items)
        for key, count in counter.items():
            if not self.top_level and count > 1 and key not in PLURAL_KEYS:
                raise KeyError(
                    f'Key "{key}" already exists in tree and would overwrite the '
                    "existing value."
                )

    @property
    def children(self) -> Tuple[Union[BlockNode, PairNode, ListNode], ...]:
        return self.items

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_container(self)

    def __str__(self) -> str:
        # TODO: This produces unparseable LookML for unquoted pair values if no suffix
        # For example, hidden: yes + dimension: ... with no whitespace in between
        return items_to_str(*self.items)


class Visitor(ABC):
    @abstractmethod
    def visit(self, document: DocumentNode) -> Any:
        ...

    @abstractmethod
    def visit_container(self, node: ContainerNode) -> Any:
        ...

    @abstractmethod
    def visit_block(self, node: BlockNode) -> Any:
        ...

    @abstractmethod
    def visit_list(self, node: ListNode) -> Any:
        ...

    @abstractmethod
    def visit_pair(self, node: PairNode) -> Any:
        ...

    @abstractmethod
    def visit_token(self, token: SyntaxToken) -> Any:
        ...
