# frozen_string_literal: true

# Interface classes between the parse tree and a data structure of primitives.
#
# These classes facilitate parsing and generation to and from simple data structures like
# lists and dictionaries, and allow users to parse and generate LookML without needing
# to interact with the parse tree.

require_relative 'keys'
require_relative 'tree'

module Lkml
  def self.pluralize(key)
    # Converts a singular key like "explore" to a plural key, e.g. 'explores'.
    case key
    when 'filters', 'bind_filters', 'extends'
      "#{key}__all"
    when 'query'
      'queries'
    when 'remote_dependency'
      'remote_dependencies'
    else
      "#{key}s"
    end
  end

  def self.singularize(key)
    # Converts a plural key like "explores" to a singular key, e.g. 'explore'.
    if key == 'queries'
      'query'
    elsif key == 'remote_dependencies'
      'remote_dependency'
    elsif key.end_with?('__all')
      key[0...-5] # Strip off __all
    elsif key.end_with?('s')
      key.chomp('s')
    else
      key
    end
  end

  class DictVisitor
    attr_accessor :depth

    def initialize
      @depth = -1
    end

    def update_tree(target, update)
      keys = update.keys
      raise KeyError, 'Dictionary to update with cannot have multiple keys.' if keys.size > 1

      key = keys.first

      if PLURAL_KEYS.include?(key)
        plural_key = ::Lkml.pluralize(key)
        if target.key?(plural_key)
          target[plural_key] << update[key]
        else
          target[plural_key] = [update[key]]
        end
      elsif target.key?(key)
        unless @depth.zero?
          raise KeyError, "Key \"#{key}\" already exists in tree and would overwrite the existing value."
        end

        $stderr << "Multiple declarations of top-level key \"#{key}\" found. Using the last-declared value.\n"
        target[key] = update[key]

      else
        target[key] = update[key]
      end
    end

    def visit(document)
      visit_container(document.container)
    end

    def visit_container(node)
      container = {}
      if node.items.any?
        @depth += 1
        node.items.each do |item|
          update_tree(container, item.accept(self))
        end
        @depth -= 1
      end
      container
    end

    def visit_block(node)
      container_dict = node.container ? node.container.accept(self) : {}
      container_dict['name'] = node.name.accept(self) if node.name
      { node.type.accept(self) => container_dict }
    end

    def visit_list(node)
      { node.type.accept(self) => node.items.map { |item| item.accept(self) } }
    end

    def visit_pair(node)
      { node.type.accept(self) => node.value.accept(self) }
    end

    def visit_token(token)
      token.value.to_s
    end
  end

  class DictParser
    attr_accessor :parent_key, :level, :base_indent, :latest_node

    def initialize
      @parent_key = nil
      @level = 0
      @base_indent = ' ' * 2
      @latest_node = DocumentNode
    end

    def increase_level
      @latest_node = nil
      @level += 1
    end

    def decrease_level
      @level -= 1
    end

    def indent
      @level.positive? ? @base_indent * @level : ''
    end

    def newline_indent
      "\n#{indent}"
    end

    def prefix
      return '' if @latest_node == DocumentNode
      return newline_indent if @latest_node.nil?
      return "\n#{newline_indent}" if @latest_node == BlockNode

      newline_indent
    end

    def plural_key?(key)
      singular_key = ::Lkml.singularize(key)
      PLURAL_KEYS.include?(singular_key) &&
        !(singular_key == 'allowed_value' && @parent_key.rstrip == 'access_grant') &&
        !(@parent_key == 'query' && singular_key != 'filters')
    end

    def resolve_filters(values)
      if values.first.key?('name')
        values.map do |value|
          name = value.delete('name')
          parse_block('filter', value, name:)
        end
      elsif values.first.key?('field') && values.first.key?('value')
        values.map { |value| parse_block('filters', value) }
      else
        parse_list('filters', values)
      end
    end

    def parse(obj)
      nodes = obj.map { |key, value| parse_any(key, value) }
      container = ContainerNode.new(nodes.flatten)
      DocumentNode.new(container)
    end

    def expand_list(key, values)
      if key == 'filters'
        resolve_filters(values)
      else
        singular_key = ::Lkml.singularize(key)
        values.map { |value| parse_any(singular_key, value) }.flatten
      end
    end

    def parse_any(key, value)
      case value
      when String
        parse_pair(key, value)
      when Array
        if plural_key?(key)
          expand_list(key, value)
        else
          parse_list(key, value)
        end
      when Hash
        to_parse = value.dup
        name = if KEYS_WITH_NAME_FIELDS.include?(key) || !value.key?('name')
                 nil
               else
                 to_parse.delete('name')
               end
        parse_block(key, to_parse, name:)
      else
        raise TypeError, 'Value must be a string, list, tuple, or dict.'
      end
    end

    def parse_block(key, items, name: nil)
      prev_parent_key = @parent_key
      @parent_key = key
      latest_node_at_this_level = @latest_node
      increase_level
      nodes = items.map { |k, v| parse_any(k, v) }
      decrease_level
      @latest_node = latest_node_at_this_level
      @parent_key = prev_parent_key

      container = ContainerNode.new(nodes.flatten)

      prefix = if @latest_node && @latest_node != DocumentNode
                 "\n#{newline_indent}"
               else
                 self.prefix
               end

      BlockNode.new(
        SyntaxToken.new(key, prefix: prefix),
        left_brace: LeftCurlyBrace.new(prefix: name ? ' ' : ''),
        right_brace: RightCurlyBrace.new(prefix: container.items.any? ? newline_indent : ''),
        name: name ? SyntaxToken.new(name) : nil,
        container: container
      ).tap { @latest_node = BlockNode }
    end

    def parse_list(key, values) # rubocop:disable Metrics/CyclomaticComplexity
      force_quote = key == 'suggestions'
      prev_parent_key = @parent_key
      @parent_key = key

      type_token = SyntaxToken.new(key, prefix: prefix)
      right_bracket = RightBracket.new
      items = []
      pair_mode = false

      pair_mode = true if values.any? && !values.first.is_a?(String)

      if values.size >= 5 || pair_mode
        Comma.new
        increase_level
        values.each do |value|
          if pair_mode
            # Extract key and value from dictionary with only one key
            key, val = value.to_a.first
            items << parse_pair(key, val)
          else
            items << parse_token(key, value, force_quote:, prefix: newline_indent)
          end
        end
        decrease_level
        right_bracket = RightBracket.new(prefix: newline_indent)
      else
        values.each_with_index do |value, i|
          token = if i.zero?
                    parse_token(key, value, force_quote:)
                  else
                    parse_token(key, value, force_quote:, prefix: ' ')
                  end
          items << token
        end
      end

      @parent_key = prev_parent_key

      ListNode.new(
        type_token,
        left_bracket: LeftBracket.new,
        items: items,
        right_bracket: right_bracket,
        trailing_comma: pair_mode || values.size >= 5 ? Comma.new : nil
      ).tap { @latest_node = ListNode }
    end

    def parse_pair(key, value)
      force_quote = @parent_key == 'filters' && key != 'field'
      value_syntax_token = parse_token(key, value, force_quote:)
      PairNode.new(
        SyntaxToken.new(key, prefix: prefix),
        value_syntax_token
      ).tap { @latest_node = PairNode }
    end

    def parse_token(key, value, force_quote: false, prefix: '', suffix: '')
      if force_quote || QUOTED_LITERAL_KEYS.include?(key)
        QuotedSyntaxToken.new(value, prefix: prefix, suffix: suffix)
      elsif EXPR_BLOCK_KEYS.include?(key)
        ExpressionSyntaxToken.new(value.strip, prefix: prefix, suffix: suffix)
      else
        SyntaxToken.new(value, prefix: prefix, suffix: suffix)
      end
    end
  end
end
