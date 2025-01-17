# frozen_string_literal: true

require_relative 'lkml/keys'
require_relative 'lkml/lexer'
require_relative 'lkml/parser'
require_relative 'lkml/simple'
require_relative 'lkml/tokens'
require_relative 'lkml/tree'
require_relative 'lkml/visitors'

module Lkml
  def self.parse(text)
    lexer = Lexer.new(text)
    tokens = lexer.scan
    Parser.new(tokens).parse
  end

  def self.dump(obj, io = nil)
    parser = DictParser.new
    result = parser.parse(obj).to_s
    return result unless io

    io.write(result)
    nil
  end
end
