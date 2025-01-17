# frozen_string_literal: true

require_relative 'keys'
require_relative 'tokens'

# Splits a LookML string into a sequence of tokens.
module Lkml
  class Lexer
    attr_reader :text, :index, :tokens, :line_number

    CHARACTER_TO_TOKEN = {
      "\0" => Tokens::StreamEndToken,
      '{' => Tokens::BlockStartToken,
      '}' => Tokens::BlockEndToken,
      '[' => Tokens::ListStartToken,
      ']' => Tokens::ListEndToken,
      ',' => Tokens::CommaToken,
      ':' => Tokens::ValueToken,
      ';' => Tokens::ExpressionBlockEndToken
    }.freeze

    def initialize(text)
      # Initializes the Lexer with a LookML string and sets the index.
      @text = "#{text}\u0000"
      @index = 0
      @tokens = []
      @line_number = 1
    end

    def peek
      # Returns the character at the current index of the text being lexed.
      @text[@index]
    end

    def peek_multiple(length)
      # Returns the next n characters from the current index in the text being lexed.
      @text[@index, length]
    end

    def advance(length = 1)
      # Moves the index forward by n characters.
      @index += length
      nil
    end

    def consume
      # Returns the current index character and advances the index 1 character.
      advance
      @text[@index - 1]
    end

    def scan # rubocop:disable Metrics/CyclomaticComplexity
      # Tokenizes LookML into a sequence of tokens.
      @tokens << Tokens::StreamStartToken.new(@line_number)
      loop do
        ch = peek
        case ch
        when "\0"
          @tokens << CHARACTER_TO_TOKEN[ch].new(@line_number)
          break
        when "\n", "\t", ' '
          @tokens << scan_whitespace
        when '#'
          advance
          @tokens << scan_comment
        when ';'
          if peek_multiple(2) == ';;'
            advance(2)
            @tokens << CHARACTER_TO_TOKEN[ch].new(@line_number)
          end
        when '"'
          advance
          @tokens << scan_quoted_literal
        when *CHARACTER_TO_TOKEN.keys
          advance
          @tokens << CHARACTER_TO_TOKEN[ch].new(@line_number)
        else
          if self.class.check_for_expression_block(peek_multiple(25))
            # TODO: Handle edges here with whitespace and comments
            @tokens << scan_literal
            advance
            @tokens << Tokens::ValueToken.new(@line_number)
            @tokens << scan_expression_block
          else
            # TODO: This should actually check for valid literals first
            # and throw an error if it doesn't match
            @tokens << scan_literal
          end
        end
      end
      @tokens
    end

    def self.check_for_expression_block(string)
      # Returns true if the input string is an expression block.
      EXPR_BLOCK_KEYS.any? { |key| string.start_with?("#{key}:") }
    end

    def scan_whitespace
      # Returns a token from one or more whitespace characters.
      chars = ''
      next_char = peek
      while ["\n", "\t", ' '].include?(next_char)
        if next_char == "\n"
          while next_char == "\n"
            chars += consume
            @line_number += 1
            next_char = peek
          end
          return Tokens::LinebreakToken.new(chars, @line_number)
        else
          chars += consume
          next_char = peek
        end
      end
      Tokens::InlineWhitespaceToken.new(chars, @line_number)
    end

    def scan_comment
      # Returns a token from a comment.
      chars = '#'
      chars += consume until ["\0", "\n"].include?(peek)
      Tokens::CommentToken.new(chars, @line_number)
    end

    def scan_expression_block
      # Returns a token from an expression block string.
      chars = ''
      while peek_multiple(2) != ';;'
        @line_number += 1 if peek == "\n"
        chars += consume
      end
      Tokens::ExpressionBlockToken.new(chars, @line_number)
    end

    def scan_literal
      # Returns a token from a literal string.
      chars = ''
      chars += consume until ["\0", ' ', "\n", "\t", ':', '}', '{', ',', ']'].include?(peek)
      Tokens::LiteralToken.new(chars, @line_number)
    end

    def scan_quoted_literal
      # Returns a token from a quoted literal string.
      chars = ''
      loop do
        ch = peek
        break if ch == '"'

        if ch == '\\'
          chars += consume # Extra consume to skip the escaped character
        elsif ch == "\n"
          @line_number += 1
        end
        chars += consume
      end
      advance
      Tokens::QuotedLiteralToken.new(chars, @line_number)
    end
  end
end
