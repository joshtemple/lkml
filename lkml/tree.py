from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Any, Counter, Optional, Tuple, Union, cast

from lkml.keys import PLURAL_KEYS


def items_to_str(*items: Any) -> str:
    """Converts each item to a string and joins them together."""
    return "".join(str(item) for item in items)


@dataclass(frozen=True)
class SyntaxToken:
    """Stores a text value with optional prefix or suffix trivia.

    For example, a syntax token might represent meaningful punctuation like a curly
    brace or the type or value of a LookML field. A syntax token can also store trivia,
    comments or whitespace that precede or follow the token value. The parser attempts
    to assign these prefixes and suffixes intelligently to the corresponding tokens.

    Attributes:
        value: The text represented by the token
        prefix: Comments or whitespace preceding the token
        suffix: Comments or whitespace following the token
    """

    value: str
    prefix: str = ""
    suffix: str = ""

    def format_value(self) -> str:
        """Returns the value itself, subclasses may modify the value first."""
        return self.value

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_token(self)

    def __str__(self) -> str:
        return items_to_str(self.prefix, self.format_value(), self.suffix)


@dataclass(frozen=True)
class LeftCurlyBrace(SyntaxToken):
    value: str = "{"


@dataclass(frozen=True)
class RightCurlyBrace(SyntaxToken):
    value: str = "}"


@dataclass(frozen=True)
class Colon(SyntaxToken):
    value: str = ":"


@dataclass(frozen=True)
class LeftBracket(SyntaxToken):
    value: str = "["


@dataclass(frozen=True)
class RightBracket(SyntaxToken):
    value: str = "]"


@dataclass(frozen=True)
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
        """Returns all child SyntaxNodes, but not SyntaxTokens."""
        ...

    @abstractmethod
    def accept(self, visitor: Visitor) -> Any:
        ...


@dataclass(frozen=True)
class PairNode(SyntaxNode):
    """A single LookML field, e.g. `hidden: yes`

    Args:
        type: [description]
        value: The value of the field
        colon: An optional Colon SyntaxToken. If not supplied, the default one is used
            with a single space suffix after the colon.

    Returns:
        [type]: [description]
    """

    type: SyntaxToken
    value: SyntaxToken
    colon: Colon = Colon(suffix=" ")

    def __repr__(self) -> str:
        return (
            f"{self.__class__.__name__}"
            f"(type='{self.type.value}', value='{self.value.value}')"
        )

    @property
    def children(self) -> None:
        return None

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_pair(self)

    def __str__(self) -> str:
        return items_to_str(self.type, self.colon, self.value)


@dataclass(frozen=True)
class ListNode(SyntaxNode):
    type: SyntaxToken
    items: Union[Tuple[PairNode, ...], Tuple[SyntaxToken, ...]]
    left_bracket: LeftBracket
    right_bracket: RightBracket
    colon: Colon = Colon(suffix=" ")
    trailing_comma: bool = False

    def __repr__(self) -> str:
        return f"{self.__class__.__name__}(type='{self.type.value}')"

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


@dataclass(frozen=True)
class BlockNode(SyntaxNode):
    type: SyntaxToken
    left_brace: LeftCurlyBrace
    right_brace: RightCurlyBrace
    colon: Optional[Colon] = Colon(suffix=" ")
    name: Optional[SyntaxToken] = None
    container: Optional[ContainerNode] = None

    def __repr__(self) -> str:
        name = f"name='{self.name.value}'" if self.name else None
        return f"{self.__class__.__name__}(type='{self.type.value}', {name})"

    @property
    def children(self) -> Optional[Tuple[ContainerNode, ...]]:
        return (self.container,) if self.container else None

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit_block(self)

    def __str__(self) -> str:
        name = self.name or ""
        container = self.container or ""
        return items_to_str(
            self.type, self.colon, name, self.left_brace, container, self.right_brace
        )


@dataclass(frozen=True)
class DocumentNode(SyntaxNode):
    container: ContainerNode
    prefix: str = ""
    suffix: str = ""

    @property
    def children(self) -> Tuple[ContainerNode]:
        return (self.container,)  # type: ignore

    def accept(self, visitor: Visitor) -> Any:
        return visitor.visit(self)

    def __str__(self) -> str:
        return items_to_str(self.prefix, self.container, self.suffix)


@dataclass(frozen=True)
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
