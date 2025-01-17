# frozen_string_literal: true

# Node and token classes that make up the parse tree.

module Lkml
  class SyntaxToken
    attr_reader :value, :line_number, :prefix, :suffix

    def initialize(value, line_number = nil, prefix: '', suffix: '')
      @value = value
      @line_number = line_number
      @prefix = prefix
      @suffix = suffix
    end

    def format_value
      @value
    end

    def accept(visitor)
      visitor.visit_token(self)
    end

    def ==(other)
      if other.is_a?(self.class)
        instance_variables.all? { |var| instance_variable_get(var) == other.instance_variable_get(var) }
      elsif other.is_a?(String)
        @value == other
      else
        false
      end
    end

    def to_s
      [@prefix, format_value, @suffix].join
    end
  end

  class LeftCurlyBrace < SyntaxToken
    def initialize(*, **)
      super('{', *, **)
    end
  end

  class RightCurlyBrace < SyntaxToken
    def initialize(*, **)
      super('}', *, **)
    end
  end

  class Colon < SyntaxToken
    def initialize(*, **)
      super(':', *, **)
    end
  end

  class LeftBracket < SyntaxToken
    def initialize(*, **)
      super('[', *, **)
    end
  end

  class RightBracket < SyntaxToken
    def initialize(*, **)
      super(']', *, **)
    end
  end

  class DoubleSemicolon < SyntaxToken
    def initialize(*, **)
      super(';;', *, **)
    end
  end

  class Comma < SyntaxToken
    def initialize(*, **)
      super(',', *, **)
    end
  end

  class QuotedSyntaxToken < SyntaxToken
    def format_value
      "\"#{@value.gsub('\"', '"').gsub('"', '\"')}\""
    end
  end

  class ExpressionSyntaxToken < SyntaxToken
    attr_reader :expr_suffix

    def initialize(value, line_number = nil, prefix: ' ', expr_suffix: ' ', suffix: '')
      super(value, line_number, prefix: prefix, suffix: suffix)
      @expr_suffix = expr_suffix
    end

    def to_s
      [@prefix, format_value, @expr_suffix, ';;', @suffix].join
    end
  end

  class SyntaxNode
    def children
      raise NotImplementedError, 'Subclasses must implement the children method'
    end

    def line_number
      raise NotImplementedError, 'Subclasses must implement the line_number method'
    end

    def accept(visitor)
      raise NotImplementedError, 'Subclasses must implement the accept method'
    end

    def ==(other)
      if other.is_a?(self.class)
        instance_variables.all? { |var| instance_variable_get(var) == other.instance_variable_get(var) }
      elsif other.is_a?(String)
        @value == other
      else
        false
      end
    end
  end

  class PairNode < SyntaxNode
    attr_reader :type, :value, :colon

    def initialize(type, value, colon: Colon.new(suffix: ' '))
      super()
      @type = type
      @value = value
      @colon = colon
    end

    def to_s
      [@type, @colon, @value].join
    end

    def children
      nil
    end

    def line_number
      @type.line_number
    end

    def accept(visitor)
      visitor.visit_pair(self)
    end
  end

  class ListNode < SyntaxNode
    attr_reader :type, :items, :left_bracket, :right_bracket, :colon, :leading_comma, :trailing_comma

    def initialize(type, items:, left_bracket:, right_bracket:, colon: Colon.new(suffix: ' '), leading_comma: nil, trailing_comma: nil) # rubocop:disable Metrics/ParameterLists,Layout/LineLength
      super()
      @type = type
      @items = items
      @left_bracket = left_bracket
      @right_bracket = right_bracket
      @colon = colon
      @leading_comma = leading_comma
      @trailing_comma = trailing_comma
    end

    def to_s
      [
        @type,
        @colon,
        @left_bracket,
        @leading_comma && @items.any? ? @leading_comma : '',
        @items.map(&:to_s).join(','),
        @trailing_comma && @items.any? ? @trailing_comma : '',
        @right_bracket
      ].join
    end

    def children
      if @items.any? && @items.first.is_a?(PairNode)
        @items
      else
        []
      end
    end

    def line_number
      @type.line_number
    end

    def accept(visitor)
      visitor.visit_list(self)
    end
  end

  class ContainerNode < SyntaxNode
    attr_reader :items, :top_level

    def initialize(items, top_level: false)
      super()
      @items = items
      @top_level = top_level
      validate_keys
    end

    def validate_keys
      counter = @items.each_with_object(Hash.new(0)) { |item, hash| hash[item.type.value] += 1 }
      counter.each do |key, count|
        if !@top_level && count > 1 && !PLURAL_KEYS.include?(key)
          raise KeyError, "Key \"#{key}\" already exists in tree and would overwrite the existing value."
        end
      end
    end

    def children
      @items
    end

    def line_number
      @items.first&.line_number
    end

    def accept(visitor)
      visitor.visit_container(self)
    end

    def to_s
      @items.map(&:to_s).join
    end
  end

  class BlockNode < SyntaxNode
    attr_reader :type, :left_brace, :right_brace, :colon, :name, :container

    def initialize(type, left_brace: LeftCurlyBrace.new(suffix: "\n"), right_brace: RightCurlyBrace.new(prefix: "\n"), colon: Colon.new(suffix: ' '), name: nil, container: ContainerNode.new([])) # rubocop:disable Metrics/ParameterLists,Layout/LineLength
      super()
      @type = type
      @left_brace = left_brace
      @right_brace = right_brace
      @colon = colon
      @name = name
      @container = container
    end

    def to_s
      [
        @type,
        @colon,
        @name || '',
        @left_brace,
        @container || '',
        @right_brace
      ].join
    end

    def children
      @container.children
    end

    def line_number
      @type.line_number
    end

    def accept(visitor)
      visitor.visit_block(self)
    end
  end

  class DocumentNode < SyntaxNode
    attr_reader :container, :prefix, :suffix

    def initialize(container, prefix: '', suffix: '')
      super()
      @container = container
      @prefix = prefix
      @suffix = suffix
    end

    def children
      [@container]
    end

    def line_number
      1
    end

    def accept(visitor)
      visitor.visit(self)
    end

    def to_s
      [@prefix, @container, @suffix].join
    end
  end

  class Visitor
    def visit(document)
      raise NotImplementedError, 'Subclasses must implement the visit method'
    end

    def visit_container(node)
      raise NotImplementedError, 'Subclasses must implement the visit_container method'
    end

    def visit_block(node)
      raise NotImplementedError, 'Subclasses must implement the visit_block method'
    end

    def visit_list(node)
      raise NotImplementedError, 'Subclasses must implement the visit_list method'
    end

    def visit_pair(node)
      raise NotImplementedError, 'Subclasses must implement the visit_pair method'
    end

    def visit_token(token)
      raise NotImplementedError, 'Subclasses must implement the visit_token method'
    end
  end
end
