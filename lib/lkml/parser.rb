# frozen_string_literal: true

# Parses a sequence of tokenized LookML into a parse tree.

require_relative 'tokens'
require_relative 'tree'

module Lkml
  class CommaSeparatedValues
    attr_accessor :trailing_comma, :leading_comma

    def initialize
      @_values = []
      @trailing_comma = nil
      @leading_comma = nil
    end

    def append(value)
      @_values << value
    end

    def values
      @_values
    end
  end

  class Parser
    attr_accessor :tokens, :index, :progress, :depth, :log_debug

    def initialize(stream)
      stream.each { |token| raise TypeError, "Unsupported token: #{token}" unless token.is_a?(Tokens::Token) }
      @tokens = stream
      @index = 0
      @progress = 0
      @depth = -1
    end

    def jump_to_index(index)
      @index = index
    end

    def peek
      @tokens[@index]
    end

    def advance(length = 1)
      @index += length
      nil
    end

    def consume
      advance
      @tokens[@index - 1]
    end

    def consume_token_value
      token = consume
      raise "Token #{token} does not have a consumable value." if token.value.nil?

      token.value
    end

    def consume_trivia(only_newlines: false)
      valid_tokens = [Tokens::CommentToken]
      valid_tokens += only_newlines ? [Tokens::LinebreakToken] : [Tokens::WhitespaceToken]

      trivia = ''
      loop do
        break unless check(*valid_tokens)

        trivia += consume_token_value
      end
      trivia
    end

    def check(*token_types, skip_trivia: false)
      mark = @index
      consume_trivia if skip_trivia

      token = begin
        peek
      rescue StandardError
        nil
      end
      result = token_types.any? { |type| token.is_a?(type) }

      jump_to_index(mark) if skip_trivia
      result
    end

    def parse
      advance if check(Tokens::StreamStartToken)
      prefix = consume_trivia
      container = parse_container
      suffix = consume_trivia
      DocumentNode.new(container, prefix: prefix, suffix: suffix)
    end

    def parse_container
      items = []
      until check(Tokens::StreamEndToken, Tokens::BlockEndToken, skip_trivia: true)
        block = parse_block
        if block
          items << block
          next
        end

        pair = parse_pair
        if pair
          items << pair
          next
        end

        list = parse_list
        if list
          items << list
          next
        end

        token = @tokens[@progress]
        raise SyntaxError, "Unable to find a matching expression for '#{token}' on line #{token.line_number}"
      end

      ContainerNode.new(items, top_level: @depth.zero?)
    end

    def parse_block
      key = parse_key
      return key if key.nil?

      name = if check(Tokens::LiteralToken)
               token = consume
               SyntaxToken.new(token.value, token.line_number)
             end

      prefix = consume_trivia
      return nil unless check(Tokens::BlockStartToken)

      advance
      suffix = consume_trivia
      left_brace = LeftCurlyBrace.new(prefix: prefix, suffix: suffix)

      container = parse_container

      prefix = consume_trivia
      return unless check(Tokens::BlockEndToken)

      advance
      suffix = consume_trivia(only_newlines: true)
      right_brace = RightCurlyBrace.new(prefix: prefix, suffix: suffix)

      BlockNode.new(
        key[0],
        colon: key[1],
        name: name,
        left_brace: left_brace,
        container: container,
        right_brace: right_brace
      )
    end

    def parse_pair
      key = parse_key
      return nil if key.nil?

      value = parse_value(parse_prefix: true, parse_suffix: true)
      return nil if value.nil?

      PairNode.new(key[0], value, colon: key[1])
    end

    def parse_key
      prefix = consume_trivia
      return nil unless check(Tokens::LiteralToken)

      token = consume
      key = SyntaxToken.new(token.value, token.line_number, prefix: prefix)

      prefix = consume_trivia

      colon = nil
      while check(Tokens::ValueToken)
        token = consume
        suffix = consume_trivia
        colon = Colon.new(token.line_number, prefix: prefix, suffix: suffix)
      end
      return nil unless colon

      [key, colon]
    end

    def parse_value(parse_prefix: false, parse_suffix: false) # rubocop:disable Metrics/CyclomaticComplexity
      prefix = parse_prefix ? consume_trivia : ''

      if check(Tokens::LiteralToken)
        token = consume
        if token.value == '-' && consume_trivia
          return nil unless check(Tokens::LiteralToken)

          token = consume
          token.value = "-#{token.value}"

        end
        suffix = parse_suffix ? consume_trivia : ''
        SyntaxToken.new(token.value, token.line_number, prefix: prefix, suffix: suffix)
      elsif check(Tokens::QuotedLiteralToken)
        token = consume
        suffix = parse_suffix ? consume_trivia : ''
        QuotedSyntaxToken.new(token.value, token.line_number, prefix: prefix, suffix: suffix)
      elsif check(Tokens::ExpressionBlockToken)
        token = consume
        match = token.value.match(/\A(\s*)(.*?)(\s*)\z/)
        expr_prefix, value, expr_suffix = if match
                                            [match[1], match[2], match[3]]
                                          else
                                            ['', token.value, '']
                                          end
        prefix += expr_prefix

        return nil unless check(Tokens::ExpressionBlockEndToken)

        advance

        suffix = parse_suffix ? consume_trivia : ''
        ExpressionSyntaxToken.new(value, token.line_number, prefix: prefix, suffix: suffix, expr_suffix: expr_suffix)
      end
    end

    def parse_list
      key = parse_key
      return key if key.nil?

      prefix = consume_trivia
      return nil unless check(Tokens::ListStartToken)

      advance
      left_bracket = LeftBracket.new(prefix: prefix)

      csv = parse_csv || CommaSeparatedValues.new

      return unless check(Tokens::ListEndToken, skip_trivia: true)

      prefix = consume_trivia
      advance
      suffix = consume_trivia
      right_bracket = RightBracket.new(prefix: prefix, suffix: suffix)
      ListNode.new(
        key[0],
        items: csv.values,
        left_bracket: left_bracket,
        right_bracket: right_bracket,
        colon: key[1],
        leading_comma: csv.leading_comma,
        trailing_comma: csv.trailing_comma
      )
    end

    def parse_csv # rubocop:disable Metrics/CyclomaticComplexity
      pair_mode = false
      csv = CommaSeparatedValues.new
      csv.leading_comma = parse_comma

      pair = parse_pair
      if pair
        csv.append(pair)
        pair_mode = true
      elsif check(Tokens::LiteralToken, Tokens::QuotedLiteralToken, skip_trivia: true)
        value = parse_value(parse_prefix: true, parse_suffix: true)
        csv.append(value)
      else
        return nil
      end

      until check(Tokens::ListEndToken, skip_trivia: true)
        return nil unless check(Tokens::CommaToken)

        index = @index
        advance
        if check(Tokens::ListEndToken, skip_trivia: true)
          jump_to_index(index)
          csv.trailing_comma = parse_comma
          break
        end

        if pair_mode
          pair = parse_pair
          return nil if pair.nil?

          csv.append(pair)
        elsif check(Tokens::LiteralToken, Tokens::QuotedLiteralToken, skip_trivia: true)
          value = parse_value(parse_prefix: true, parse_suffix: true)
          csv.append(value)
        elsif check(Tokens::ListEndToken, skip_trivia: true)
          break
        else
          return nil
        end
      end

      csv
    end

    def parse_comma
      prefix = consume_trivia

      return unless check(Tokens::CommaToken)

      advance
      suffix = check(Tokens::ListEndToken, skip_trivia: true) ? '' : consume_trivia
      Comma.new(prefix: prefix, suffix: suffix)
    end

    def self.backtrack_if_none(method_name)
      original_method = instance_method(method_name)

      define_method(method_name) do |*args, **kwargs|
        mark = @index
        @depth += 1
        result = original_method.bind(self).call(*args, **kwargs)
        @depth -= 1
        if result.nil?
          @progress = [@index, @progress].max
          jump_to_index(mark)
        end
        result
      end
    end

    backtrack_if_none :parse_container
    backtrack_if_none :parse_block
    backtrack_if_none :parse_pair
    backtrack_if_none :parse_key
    backtrack_if_none :parse_value
    backtrack_if_none :parse_list
    backtrack_if_none :parse_csv
    backtrack_if_none :parse_comma
  end
end
