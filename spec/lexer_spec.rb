# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Lexer' do
  let(:lexer) { Lkml::Lexer.new('Some sample text for testing.') }

  it 'peek does not advance index' do
    index = lexer.index
    lexer.peek
    expect(lexer.index).to eq(index)
  end

  it 'peek default returns one character' do
    result = lexer.peek
    expect(result.length).to eq(1)
    expect(result).to be_a(String)
  end

  it 'peek multiple with more than one returns correct characters' do
    result = lexer.peek_multiple(2)
    expect(result.length).to eq(2)
    result = lexer.peek_multiple(3)
    expect(result.length).to eq(3)
  end

  it 'advance does not return a character' do
    result = lexer.advance
    expect(result).to be_nil
  end

  it 'advance increases index by length' do
    index = lexer.index
    lexer.advance
    expect(lexer.index).to eq(index + 1)

    index = lexer.index
    lexer.advance(3)
    expect(lexer.index).to eq(index + 3)
  end

  it 'consume advances index by one' do
    index = lexer.index
    lexer.consume
    expect(lexer.index).to eq(index + 1)
  end

  it 'consume returns current character' do
    current_char = lexer.text[lexer.index]
    char = lexer.consume
    expect(char).to eq(current_char)
  end

  params = [
    ["\0", Lkml::Tokens::StreamEndToken.new(1)],
    ['{', Lkml::Tokens::BlockStartToken.new(1)],
    ['}', Lkml::Tokens::BlockEndToken.new(1)],
    ['[', Lkml::Tokens::ListStartToken.new(1)],
    [']', Lkml::Tokens::ListEndToken.new(1)],
    [',', Lkml::Tokens::CommaToken.new(1)],
    [':', Lkml::Tokens::ValueToken.new(1)],
    [';;', Lkml::Tokens::ExpressionBlockEndToken.new(1)]
  ]

  params.each do |text, expected|
    it "scan all simple tokens for #{text}" do
      lexer = Lkml::Lexer.new(text)
      result = lexer.scan
      expect(result[1]).to eq(expected)
    end
  end

  it 'scan whitespace' do
    text = "\n\t Hello World!"
    lexer = Lkml::Lexer.new(text)
    token = lexer.scan_whitespace
    expect(token).to eq(Lkml::Tokens::LinebreakToken.new("\n", 1))
    token = lexer.scan_whitespace
    expect(token).to eq(Lkml::Tokens::InlineWhitespaceToken.new("\t ", 2))
  end

  it 'scan comment' do
    text = "# Make this better \n"
    lexer = Lkml::Lexer.new(text)
    lexer.advance
    token = lexer.scan_comment
    expect(token).to eq(Lkml::Tokens::CommentToken.new('# Make this better ', 1))
  end

  it 'scan comment with surrounding whitespace' do
    text = "\n# A comment\n "
    output = Lkml::Lexer.new(text).scan
    expect(output).to eq([
                           Lkml::Tokens::StreamStartToken.new(1),
                           Lkml::Tokens::LinebreakToken.new("\n", 1),
                           Lkml::Tokens::CommentToken.new('# A comment', 2),
                           Lkml::Tokens::LinebreakToken.new("\n", 2),
                           Lkml::Tokens::InlineWhitespaceToken.new(' ', 3),
                           Lkml::Tokens::StreamEndToken.new(3)
                         ])
  end

  it 'scan quoted literal' do
    text = '"This is quoted text."'
    lexer = Lkml::Lexer.new(text)
    lexer.advance
    token = lexer.scan_quoted_literal
    expect(token).to eq(Lkml::Tokens::QuotedLiteralToken.new('This is quoted text.', 1))
  end

  it 'scan quoted literal with otherwise illegal chars' do
    text = "\"This: is {quoted} \n text.\""
    lexer = Lkml::Lexer.new(text)
    lexer.advance
    token = lexer.scan_quoted_literal
    expect(token).to eq(Lkml::Tokens::QuotedLiteralToken.new("This: is {quoted} \n text.", 1))
  end

  it 'scan quoted literal with escaped quotes' do
    text = '"#.### \\"M\\""'
    lexer = Lkml::Lexer.new(text)
    lexer.advance
    token = lexer.scan_quoted_literal
    expect(token).to eq(Lkml::Tokens::QuotedLiteralToken.new('#.### \\"M\\"', 1))
  end

  it 'scan literal' do
    text = 'unquoted_literal'
    token = Lkml::Lexer.new(text).scan_literal
    expect(token).to eq(Lkml::Tokens::LiteralToken.new('unquoted_literal', 1))
  end

  it 'scan literal with following whitespace' do
    text = "unquoted_literal \n and text following whitespace"
    token = Lkml::Lexer.new(text).scan_literal
    expect(token).to eq(Lkml::Tokens::LiteralToken.new('unquoted_literal', 1))
  end

  it 'scan expression block with complex sql block' do
    text = "concat(${orders.order_id}, '|', ${orders__items.primary_key}) ;;"
    token = Lkml::Lexer.new(text).scan_expression_block
    expect(token).to eq(Lkml::Tokens::ExpressionBlockToken.new(
                          "concat(${orders.order_id}, '|', ${orders__items.primary_key}) ", 1
                        ))
  end

  it 'scan with complex sql block' do
    text = "sql_distinct_key: concat(${orders.order_id}, '|', ${orders__items.primary_key}) ;;"
    output = Lkml::Lexer.new(text).scan
    expect(output).to eq([
                           Lkml::Tokens::StreamStartToken.new(1),
                           Lkml::Tokens::LiteralToken.new('sql_distinct_key', 1),
                           Lkml::Tokens::ValueToken.new(1),
                           Lkml::Tokens::ExpressionBlockToken.new(
                             " concat(${orders.order_id}, '|', ${orders__items.primary_key}) ", 1
                           ),
                           Lkml::Tokens::ExpressionBlockEndToken.new(1),
                           Lkml::Tokens::StreamEndToken.new(1)
                         ])
  end

  it 'scan with non-expression block starting with sql' do
    text = 'sql_not_reserved_field: yes'
    output = Lkml::Lexer.new(text).scan
    expect(output).to eq([
                           Lkml::Tokens::StreamStartToken.new(1),
                           Lkml::Tokens::LiteralToken.new('sql_not_reserved_field', 1),
                           Lkml::Tokens::ValueToken.new(1),
                           Lkml::Tokens::InlineWhitespaceToken.new(' ', 1),
                           Lkml::Tokens::LiteralToken.new('yes', 1),
                           Lkml::Tokens::StreamEndToken.new(1)
                         ])
  end

  it 'scan with non-expression block starting with html' do
    text = 'html_not_reserved_field: yes'
    output = Lkml::Lexer.new(text).scan
    expect(output).to eq([
                           Lkml::Tokens::StreamStartToken.new(1),
                           Lkml::Tokens::LiteralToken.new('html_not_reserved_field', 1),
                           Lkml::Tokens::ValueToken.new(1),
                           Lkml::Tokens::InlineWhitespaceToken.new(' ', 1),
                           Lkml::Tokens::LiteralToken.new('yes', 1),
                           Lkml::Tokens::StreamEndToken.new(1)
                         ])
  end
end
