# frozen_string_literal: true

# Tokens used by the lexer to tokenize LookML.

module Lkml
  module Tokens
    class Token
      # Base class for LookML tokens, lexed from LookML strings.

      attr_reader :line_number

      def initialize(line_number)
        # Initializes a Token.
        #
        # Args:
        #   line_number: The corresponding line in the text where this token begins

        @line_number = line_number
      end

      def ==(other)
        # Compare one Token to another by their type.
        self.class == other.class
      end

      def to_s
        # Returns the token's string representation, truncated to 25 characters.
        #
        # If the token has a `value` attribute, include that in the output.

        value = defined?(@value) ? @value.strip : ''
        value = "#{value[0, 25].rstrip} ... " if value.length > 25
        "#{self.class.name}(#{value})"
      end
    end

    class ContentToken < Token
      # Base class for LookML tokens that contain a string of content.

      attr_accessor :value

      def initialize(value, line_number)
        # Initializes a ContentToken with string content.
        #
        # Args:
        #   value: A string value for the token's content
        #   line_number: The corresponding line in the text where this token begins

        @value = value
        super(line_number)
      end

      def ==(other)
        # Compare one ContentToken to another by their values.
        self.class == other.class && @value == other.value
      end
    end

    class StreamStartToken < Token
      # Represents the start of a stream of characters.

      def initialize(line_number)
        super
        @id = '<stream start>'
      end
    end

    class StreamEndToken < Token
      # Represents the end of a stream of characters.

      def initialize(line_number)
        super
        @id = '<stream end>'
      end
    end

    class BlockStartToken < Token
      # Represents the start of a block.

      def initialize(line_number)
        super
        @id = '{'
      end
    end

    class BlockEndToken < Token
      # Represents the end of a block.

      def initialize(line_number)
        super
        @id = '}'
      end
    end

    class ValueToken < Token
      # Separates a key from a value.

      def initialize(line_number)
        super
        @id = ':'
      end
    end

    class ExpressionBlockEndToken < Token
      # Represents the end of an expression block.

      def initialize(line_number)
        super
        @id = ';;'
      end
    end

    class CommaToken < Token
      # Separates elements in a list.

      def initialize(line_number)
        super
        @id = ','
      end
    end

    class ListStartToken < Token
      # Represents the start of a list.

      def initialize(line_number)
        super
        @id = '['
      end
    end

    class ListEndToken < Token
      # Represents the end of a list.

      def initialize(line_number)
        super
        @id = ']'
      end
    end

    class TriviaToken < ContentToken
      # Represents a comment or whitespace.
    end

    class WhitespaceToken < TriviaToken
      # Represents one or more whitespace characters.

      def initialize(value, line_number)
        super
        @id = '<whitespace>'
      end

      def to_s
        "#{self.class.name}(#{@value.inspect})"
      end
    end

    class LinebreakToken < WhitespaceToken
      # Represents a newline character.

      def initialize(value, line_number)
        super
        @id = '<linebreak>'
      end
    end

    class InlineWhitespaceToken < WhitespaceToken
      # Represents one or more whitespace characters.

      def initialize(value, line_number)
        super
        @id = '<inline whitespace>'
      end
    end

    class CommentToken < TriviaToken
      # Represents a comment.

      def initialize(value, line_number)
        super
        @id = '<comment>'
      end
    end

    class ExpressionBlockToken < ContentToken
      # Contains the value of an expression block.

      def initialize(value, line_number)
        super
        @id = '<expression block>'
      end
    end

    class LiteralToken < ContentToken
      # Contains the value of an unquoted literal.

      def initialize(value, line_number)
        super
        @id = '<literal>'
      end
    end

    class QuotedLiteralToken < ContentToken
      # Contains the value of a quoted literal.

      def initialize(value, line_number)
        super
        @id = '<quoted literal>'
      end
    end
  end
end
