# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Lkml::Parser do
  let(:parser) do
    stream = [
      Lkml::Tokens::StreamStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('view', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name', 1),
      Lkml::Tokens::BlockStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('sql_table_name', 2),
      Lkml::Tokens::ValueToken.new(2),
      Lkml::Tokens::ExpressionBlockToken.new('schema.table_name', 2),
      Lkml::Tokens::ExpressionBlockEndToken.new(2),
      Lkml::Tokens::LiteralToken.new('drill_fields', 3),
      Lkml::Tokens::ValueToken.new(3),
      Lkml::Tokens::ListStartToken.new(3),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 3),
      Lkml::Tokens::CommaToken.new(3),
      Lkml::Tokens::LiteralToken.new('view_name.field_two', 3),
      Lkml::Tokens::ListEndToken.new(3),
      Lkml::Tokens::BlockEndToken.new(4),
      Lkml::Tokens::StreamEndToken.new(4)
    ]
    described_class.new(stream)
  end

  it 'initializes parser index at zero' do
    expect(parser.index).to eq(0)
  end

  it 'has tokens after initialization' do
    expect(parser.tokens.length).to be > 0
  end

  it 'raises TypeError if non-token elements are passed' do
    expect { described_class.new(['a', 'b', 'c', 'd', 1, 2, 3, 4]) }.to raise_error(TypeError)
  end

  it 'peek does not advance index' do
    index = parser.index
    parser.peek
    expect(parser.index).to eq(index)
  end

  it 'peek returns a token' do
    result = parser.peek
    expect(result).to be_a(Lkml::Tokens::Token)
  end

  it 'advance does not return a token' do
    result = parser.advance
    expect(result).to be_nil
  end

  it 'advance increases index by length' do
    index = parser.index
    parser.advance
    expect(parser.index).to eq(index + 1)

    index = parser.index
    parser.advance(3)
    expect(parser.index).to eq(index + 3)
  end

  it 'consume advances index by one' do
    index = parser.index
    parser.consume
    expect(parser.index).to eq(index + 1)
  end

  it 'consume returns current token' do
    current_token = parser.tokens[parser.index]
    token = parser.consume
    expect(token).to eq(current_token)
  end

  it 'consume_token_value does not return token' do
    parser.index = 1
    result = parser.consume_token_value
    expect(result).not_to be_a(Lkml::Tokens::Token)
    expect(result).to eq('view')
  end

  it 'consume_token_value raises error if not found' do
    expect { parser.consume_token_value }.to raise_error(NoMethodError)
  end

  it 'check returns true for single valid type' do
    expect(parser.check(Lkml::Tokens::StreamStartToken)).to be true
  end

  it 'check returns false for single invalid type' do
    expect(parser.check(Lkml::Tokens::ValueToken)).to be false
  end

  it 'check returns true for mix of valid and invalid types' do
    expect(parser.check(Lkml::Tokens::ValueToken, Lkml::Tokens::StreamStartToken)).to be true
  end

  it 'check returns false for all invalid types' do
    expect(parser.check(Lkml::Tokens::ValueToken, Lkml::Tokens::QuotedLiteralToken)).to be false
  end

  it 'parse_value with quoted literal' do
    quoted_literal = 'This is a quoted literal.'
    stream = [
      Lkml::Tokens::QuotedLiteralToken.new(quoted_literal, 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_value
    expect(result).to eq(Lkml::QuotedSyntaxToken.new(quoted_literal, 1))
  end

  it 'parse_value with literal' do
    literal = 'This is an unquoted literal.'
    stream = [
      Lkml::Tokens::LiteralToken.new(literal, 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_value
    expect(result).to eq(Lkml::SyntaxToken.new(literal, 1))
  end

  it 'parse_value with literal and sql block' do
    literal = 'SELECT * FROM tablename'
    stream = [
      Lkml::Tokens::LiteralToken.new(literal, 1),
      Lkml::Tokens::ExpressionBlockEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_value
    expect(result).to eq(Lkml::SyntaxToken.new(literal, 1))
  end

  it 'parse_value with invalid tokens' do
    stream = [
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_value
    expect(result).to be_nil
  end

  it 'parse_value with quoted literal and leftovers' do
    quoted_literal = 'This is a quoted literal.'
    literal = 'Some other tokens following.'
    stream = [
      Lkml::Tokens::QuotedLiteralToken.new(quoted_literal, 1),
      Lkml::Tokens::LiteralToken.new(literal, 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_value
    expect(result).to eq(Lkml::QuotedSyntaxToken.new(quoted_literal, 1))
    expect(parser.index).to eq(1)
  end

  it 'parse_value without closing double semicolons' do
    stream = [
      Lkml::Tokens::ExpressionBlockToken.new('SELECT * FROM TABLE', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_value
    expect(result).to be_nil
  end

  it 'parse_key normal returns token value' do
    stream = [
      Lkml::Tokens::LiteralToken.new('label', 1),
      Lkml::Tokens::ValueToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_key
    expect(result).to eq([Lkml::SyntaxToken.new('label', 1), Lkml::Colon.new(1)])
  end

  it 'parse_key without literal token' do
    stream = [
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_key
    expect(result).to be_nil
  end

  it 'parse_key without value token' do
    stream = [
      Lkml::Tokens::LiteralToken.new('label', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_key
    expect(result).to be_nil
  end

  it 'parse_key with many value tokens' do
    stream = [
      Lkml::Tokens::LiteralToken.new('label', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new('  ', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new("\t", 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_key
    expect(result).to eq([Lkml::SyntaxToken.new('label', 1), Lkml::Colon.new(1, suffix: "\t")])
  end

  it 'parse_block without closing curly brace' do
    stream = [
      Lkml::Tokens::LiteralToken.new('view', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::BlockStartToken.new(1),
      Lkml::Tokens::WhitespaceToken.new("\n", 1),
      Lkml::Tokens::LiteralToken.new('hidden', 2),
      Lkml::Tokens::ValueToken.new(2),
      Lkml::Tokens::WhitespaceToken.new(' ', 2),
      Lkml::Tokens::LiteralToken.new('yes', 2),
      Lkml::Tokens::StreamEndToken.new(3)
    ]
    parser = described_class.new(stream)
    result = parser.parse_block
    expect(result).to be_nil
  end

  it 'parse_nonmatching_container raises syntax error' do
    stream = [
      Lkml::Tokens::LiteralToken.new('view', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    expect { parser.parse_container }.to raise_error(SyntaxError)
  end

  it 'parse_pair with literal' do
    stream = [
      Lkml::Tokens::LiteralToken.new('hidden', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('yes', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_pair
    expect(result).to eq(Lkml::PairNode.new(
                           Lkml::SyntaxToken.new('hidden', 1),
                           Lkml::SyntaxToken.new('yes', 1),
                           colon: Lkml::Colon.new(1, suffix: ' ')
                         ))
  end

  it 'parse_pair with quoted literal' do
    stream = [
      Lkml::Tokens::LiteralToken.new('view_label', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::QuotedLiteralToken.new('The View', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_pair
    expect(result).to eq(Lkml::PairNode.new(
                           Lkml::SyntaxToken.new('view_label', 1),
                           Lkml::QuotedSyntaxToken.new('The View', 1),
                           colon: Lkml::Colon.new(1, suffix: ' ')
                         ))
    expect { result.prefix }.to raise_error(NoMethodError)
  end

  it 'parse_pair with sql block' do
    sql = ' SELECT * FROM schema.table '
    stream = [
      Lkml::Tokens::LiteralToken.new('sql', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ExpressionBlockToken.new(sql, 1),
      Lkml::Tokens::ExpressionBlockEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_pair
    expect(result).to eq(Lkml::PairNode.new(
                           Lkml::SyntaxToken.new('sql', 1),
                           Lkml::ExpressionSyntaxToken.new(sql.strip, 1),
                           colon: Lkml::Colon.new(1, suffix: ' ')
                         ))
  end

  it 'parse_pair with bad key' do
    stream = [
      Lkml::Tokens::QuotedLiteralToken.new('hidden', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('yes', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_pair
    expect(result).to be_nil
  end

  it 'parse_pair without value token' do
    stream = [
      Lkml::Tokens::LiteralToken.new('hidden', 1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('yes', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_pair
    expect(result).to be_nil
  end

  it 'parse_list with literals' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('view_name.field_two', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('view_name.field_three', 1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [
                             Lkml::SyntaxToken.new('view_name.field_one', 1),
                             Lkml::SyntaxToken.new('view_name.field_two', 1, prefix: ' '),
                             Lkml::SyntaxToken.new('view_name.field_three', 1, prefix: ' ')
                           ],
                           right_bracket: Lkml::RightBracket.new
                         ))
  end

  it 'parse_list with pairs' do
    stream = [
      Lkml::Tokens::LiteralToken.new('sorts', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('orders.customer_id', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('asc', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::LiteralToken.new('orders.order_id', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('desc', 1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('sorts', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [
                             Lkml::PairNode.new(
                               Lkml::SyntaxToken.new('orders.customer_id', 1),
                               Lkml::SyntaxToken.new('asc', 1),
                               colon: Lkml::Colon.new(1, suffix: ' ')
                             ),
                             Lkml::PairNode.new(
                               Lkml::SyntaxToken.new('orders.order_id', 1),
                               Lkml::SyntaxToken.new('desc', 1),
                               colon: Lkml::Colon.new(1, suffix: ' ')
                             )
                           ],
                           right_bracket: Lkml::RightBracket.new
                         ))

    stream = [
      Lkml::Tokens::LiteralToken.new('filters', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::WhitespaceToken.new("\n  ", 1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 2),
      Lkml::Tokens::ValueToken.new(2),
      Lkml::Tokens::WhitespaceToken.new(' ', 2),
      Lkml::Tokens::QuotedLiteralToken.new('-0,-1,-8,-9,-99,-NULL,-EMPTY', 2),
      Lkml::Tokens::WhitespaceToken.new("\n", 2),
      Lkml::Tokens::ListEndToken.new(3),
      Lkml::Tokens::StreamEndToken.new(3)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('filters', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [
                             Lkml::PairNode.new(
                               Lkml::SyntaxToken.new('view_name.field_one', 2, prefix: "\n  "),
                               Lkml::QuotedSyntaxToken.new('-0,-1,-8,-9,-99,-NULL,-EMPTY', 2, suffix: "\n"),
                               colon: Lkml::Colon.new(2, suffix: ' ')
                             )
                           ],
                           right_bracket: Lkml::RightBracket.new
                         ))
  end

  it 'parse_list with trailing comma' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [Lkml::SyntaxToken.new('view_name.field_one', 1)],
                           trailing_comma: Lkml::Comma.new,
                           right_bracket: Lkml::RightBracket.new
                         ))

    # Test when the list items are separated by newlines
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::WhitespaceToken.new("\n  ", 1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 2),
      Lkml::Tokens::CommaToken.new(2),
      Lkml::Tokens::WhitespaceToken.new("\n", 2),
      Lkml::Tokens::ListEndToken.new(3),
      Lkml::Tokens::StreamEndToken.new(3)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [Lkml::SyntaxToken.new('view_name.field_one', 2, prefix: "\n  ")],
                           trailing_comma: Lkml::Comma.new,
                           right_bracket: Lkml::RightBracket.new(prefix: "\n")
                         ))
  end

  it 'parse_list with leading comma' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [Lkml::SyntaxToken.new('view_name.field_one', 1)],
                           right_bracket: Lkml::RightBracket.new,
                           leading_comma: Lkml::Comma.new
                         ))
  end

  it 'parse_list with missing comma' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_two', 1),
      Lkml::Tokens::LiteralToken.new('view_name.field_three', 1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to be_nil
  end

  it 'parse_list with no contents' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [],
                           right_bracket: Lkml::RightBracket.new
                         ))

    # Add whitespace between brackets
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [],
                           right_bracket: Lkml::RightBracket.new(prefix: ' ')
                         ))
  end

  it 'parse_list with no opening bracket' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_two', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to be_nil
  end

  it 'parse_list with bad token' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_two', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to be_nil
  end

  it 'parse_list with only commas' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to be_nil
  end

  it 'parse_list with trailing comment' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 1),
      Lkml::Tokens::CommaToken.new(1),
      Lkml::Tokens::LiteralToken.new('view_name.field_two', 1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::CommentToken.new('# This is a comment', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [
                             Lkml::SyntaxToken.new('view_name.field_one', 1),
                             Lkml::SyntaxToken.new('view_name.field_two', 1)
                           ],
                           right_bracket: Lkml::RightBracket.new(suffix: ' # This is a comment')
                         ))
  end

  it 'parse_list with inner comment' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::WhitespaceToken.new("\n  ", 1),
      Lkml::Tokens::LiteralToken.new('view_name.field_one', 2),
      Lkml::Tokens::CommaToken.new(2),
      Lkml::Tokens::WhitespaceToken.new("\n  ", 2),
      Lkml::Tokens::LiteralToken.new('view_name.field_two', 3),
      Lkml::Tokens::WhitespaceToken.new(' ', 3),
      Lkml::Tokens::CommentToken.new('# This is a comment', 3),
      Lkml::Tokens::WhitespaceToken.new("\n", 3),
      Lkml::Tokens::ListEndToken.new(4),
      Lkml::Tokens::StreamEndToken.new(4)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [
                             Lkml::SyntaxToken.new('view_name.field_one', 2, prefix: "\n  "),
                             Lkml::SyntaxToken.new('view_name.field_two', 3, prefix: "\n  ",
                                                                             suffix: " # This is a comment\n")
                           ],
                           right_bracket: Lkml::RightBracket.new
                         ))
  end

  it 'parse_list with only comment' do
    stream = [
      Lkml::Tokens::LiteralToken.new('drill_fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::WhitespaceToken.new("\n  ", 1),
      Lkml::Tokens::CommentToken.new('# Put some fields here', 2),
      Lkml::Tokens::WhitespaceToken.new("\n", 2),
      Lkml::Tokens::ListEndToken.new(3),
      Lkml::Tokens::StreamEndToken.new(3)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('drill_fields', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_bracket: Lkml::LeftBracket.new,
                           items: [],
                           right_bracket: Lkml::RightBracket.new(prefix: "\n  # Put some fields here\n")
                         ))
  end

  it 'parse_list with space delimited hyphen' do
    stream = [
      Lkml::Tokens::LiteralToken.new('fields', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::ListStartToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('-', 1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('view.dimension_name', 1),
      Lkml::Tokens::ListEndToken.new(1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_list
    expect(result).to eq(Lkml::ListNode.new(
                           Lkml::SyntaxToken.new('fields', 1),
                           items: [Lkml::SyntaxToken.new('-view.dimension_name', 1, prefix: ' ')],
                           left_bracket: Lkml::LeftBracket.new,
                           right_bracket: Lkml::RightBracket.new,
                           colon: Lkml::Colon.new(1, suffix: ' ')
                         ))
  end

  it 'parse_block with no expression' do
    stream = [
      Lkml::Tokens::LiteralToken.new('dimension', 1),
      Lkml::Tokens::ValueToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::LiteralToken.new('dimension_name', 1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::BlockStartToken.new(1),
      Lkml::Tokens::BlockEndToken.new(1),
      Lkml::Tokens::WhitespaceToken.new(' ', 1),
      Lkml::Tokens::StreamEndToken.new(1)
    ]
    parser = described_class.new(stream)
    result = parser.parse_block
    expect(result).to eq(Lkml::BlockNode.new(
                           Lkml::SyntaxToken.new('dimension', 1),
                           name: Lkml::SyntaxToken.new('dimension_name', 1),
                           colon: Lkml::Colon.new(1, suffix: ' '),
                           left_brace: Lkml::LeftCurlyBrace.new(prefix: ' '),
                           container: Lkml::ContainerNode.new([]),
                           right_brace: Lkml::RightCurlyBrace.new
                         ))
  end
end
