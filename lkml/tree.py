"""Node and token classes that make up the parse tree."""

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
        value: The text represented by the token.
        prefix: Comments or whitespace preceding the token.
        suffix: Comments or whitespace following the token.

    """

    value: str
    line_number: Optional[int] = None
    prefix: str = ""
    suffix: str = ""

    def format_value(self) -> str:
        """Returns the value itself, subclasses may modify the value first."""
        return self.value

    def accept(self, visitor: Visitor) -> Any:
        """Accepts a visitor and calls the visitor's token method on itself."""
        return visitor.visit_token(self)

    def __eq__(self, other: Any) -> bool:
        if isinstance(other, self.__class__):
            return self.__dict__ == other.__dict__
        elif isinstance(other, str):
            return self.value == other
        else:
            return NotImplemented

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


@dataclass(frozen=True)
class Comma(SyntaxToken):
    value: str = ","


class QuotedSyntaxToken(SyntaxToken):
    def format_value(self) -> str:
        # Escape double quotes since the whole value is quoted
        return '"' + self.value.replace(r"\"", '"').replace('"', r"\"") + '"'


@dataclass(frozen=True)
class ExpressionSyntaxToken(SyntaxToken):
    prefix: str = " "
    expr_suffix: str = " "

    def __str__(self) -> str:
        return items_to_str(
            self.prefix, self.format_value(), self.expr_suffix, ";;", self.suffix
        )


class SyntaxNode(ABC):
    """Abstract base class for members of the parse tree that have child nodes."""

    @property
    @abstractmethod
    def children(self) -> Optional[Tuple[SyntaxNode, ...]]:
        """Returns all child SyntaxNodes, but not SyntaxTokens."""
        ...

    @property
    @abstractmethod
    def line_number(self) -> Optional[int]:
        """Returns the line number of the first SyntaxToken in the node"""
        ...

    @abstractmethod
    def accept(self, visitor: Visitor) -> Any:
        """Accepts a Visitor that can interact with the node.

        The visitor pattern allows for flexible algorithms that can traverse the tree
        without needing to be defined as methods on the tree itself.

        """
        ...


@dataclass(frozen=True)
class PairNode(SyntaxNode):
    """A simple LookML field, e.g. ``hidden: yes``.

    Attributes:
        type: The field type, the value that precedes the colon.
        value: The field value, the value that follows the colon.
        colon: An optional Colon SyntaxToken. If not supplied, a default colon is
            created with a single space suffix after the colon.

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

    @property
    def line_number(self) -> Optional[int]:
        return self.type.line_number

    def accept(self, visitor: Visitor) -> Any:
        """Accepts a visitor and calls the visitor's pair method on itself."""
        return visitor.visit_pair(self)

    def __str__(self) -> str:
        return items_to_str(self.type, self.colon, self.value)


@dataclass(frozen=True)
class ListNode(SyntaxNode):
    """A LookML list, enclosed in square brackets. Like ``fields`` or ``filters``.

    Attributes:
        type: The field type, the value that precedes the colon.
        items: A tuple of pair nodes or syntax tokens, depending on the list style.
        left_bracket: A syntax token for the opening bracket "[".
        right_bracket: A syntax token for the closing bracket "]".
        colon: An optional Colon SyntaxToken. If not supplied, a default colon is
            created with a single space suffix after the colon.
        trailing_comma: Include a trailing comma after the last item.

    """

    type: SyntaxToken
    items: Union[Tuple[PairNode, ...], Tuple[SyntaxToken, ...]]
    left_bracket: LeftBracket
    right_bracket: RightBracket
    colon: Colon = Colon(suffix=" ")
    leading_comma: Optional[Comma] = None
    trailing_comma: Optional[Comma] = None

    def __repr__(self) -> str:
        return f"{self.__class__.__name__}(type='{self.type.value}')"

    @property
    def children(self,) -> Tuple[PairNode, ...]:
        if self.items and isinstance(self.items[0], PairNode):
            # Assume that all elements are pairs
            return cast(Tuple[PairNode, ...], self.items)
        else:
            return tuple()

    @property
    def line_number(self) -> Optional[int]:
        return self.type.line_number

    def accept(self, visitor: Visitor) -> Any:
        """Accepts a visitor and calls the visitor's list method on itself."""
        return visitor.visit_list(self)

    def __str__(self) -> str:
        return items_to_str(
            self.type,
            self.colon,
            self.left_bracket,
            self.leading_comma if self.leading_comma and len(self.items) > 0 else "",
            ",".join(str(item) for item in self.items),
            self.trailing_comma if self.trailing_comma and len(self.items) > 0 else "",
            self.right_bracket,
        )


@dataclass(frozen=True)
class ContainerNode(SyntaxNode):
    """A sequence of nodes, either at the top level of a document, or within a block.

    Attributes:
        items: A tuple of the contained nodes.
        top_level: If the container is the top level of the LookML document.

    Raises:
        KeyError: If a key already exists in the tree and would be overwritten.

    """

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

    def line_number(self) -> Optional[int]:
        try:
            first_item = self.items[0]
        except IndexError:
            return None
        else:
            return first_item.line_number

    def accept(self, visitor: Visitor) -> Any:
        """Accepts a visitor and calls the visitor's container method on itself."""
        return visitor.visit_container(self)

    def __str__(self) -> str:
        # TODO: This produces unparseable LookML for unquoted pair values if no suffix
        # For example, hidden: yes + dimension: ... with no whitespace in between
        return items_to_str(*self.items)


@dataclass(frozen=True)
class BlockNode(SyntaxNode):
    """A LookML block, enclosed in curly braces. Like ``view`` or ``dimension``.

    Attributes:
        type: The field type, the value that precedes the colon.
        left_brace: A syntax token for the opening brace "{".
        right_brace: A syntax token for the closing brace "}".
        colon: An optional Colon SyntaxToken. If not supplied, a default colon is
            created with a single space suffix after the colon.
        name: An optional name token, the value that follows the colon.
        container: A container node that holds the block's child nodes.

    """

    type: SyntaxToken
    left_brace: LeftCurlyBrace = LeftCurlyBrace(suffix="\n")
    right_brace: RightCurlyBrace = RightCurlyBrace(prefix="\n")
    colon: Optional[Colon] = Colon(suffix=" ")
    name: Optional[SyntaxToken] = None
    container: ContainerNode = ContainerNode(items=tuple())

    def __repr__(self) -> str:
        name = f"name='{self.name.value}'" if self.name else None
        return f"{self.__class__.__name__}(type='{self.type.value}', {name})"

    @property
    def children(self) -> Tuple[Union[BlockNode, PairNode, ListNode], ...]:
        return self.container.children

    @property
    def line_number(self) -> Optional[int]:
        return self.type.line_number

    def accept(self, visitor: Visitor) -> Any:
        """Accepts a visitor and calls the visitor's block method on itself."""
        return visitor.visit_block(self)

    def __str__(self) -> str:
        name = self.name or ""
        container = self.container or ""
        return items_to_str(
            self.type, self.colon, name, self.left_brace, container, self.right_brace
        )


@dataclass(frozen=True)
class DocumentNode(SyntaxNode):
    """The root node of the parse tree.

    Attributes:
        container: The top-level container node.
        prefix: Leading whitespace or comments before the document.
        suffix: Trailing whitespace or comments after the document.

    """

    container: ContainerNode
    prefix: str = ""
    suffix: str = ""

    @property
    def children(self) -> Tuple[ContainerNode]:
        return (self.container,)

    @property
    def line_number(self) -> Optional[int]:
        return 1  # Document always starts on the first line

    def accept(self, visitor: Visitor) -> Any:
        """Accepts a visitor and calls the visitor's visit method on itself."""
        return visitor.visit(self)

    def __str__(self) -> str:
        return items_to_str(self.prefix, self.container, self.suffix)


class Visitor(ABC):
    """Abstract base class for visitors that interact with the parse tree."""

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
