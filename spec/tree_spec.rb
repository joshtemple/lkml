# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'SyntaxToken' do
  it 'returns formatted string' do
    expect(Lkml::SyntaxToken.new('foo').to_s).to eq('foo')
    expect(Lkml::QuotedSyntaxToken.new('foo').to_s).to eq('"foo"')
  end

  it 'quotes double quotes in QuotedSyntaxToken' do
    text = 'This is the "best" dimension'
    token = Lkml::QuotedSyntaxToken.new(text)
    expect(token.format_value).to eq('"This is the \"best\" dimension"')
  end

  it 'handles expression suffix in ExpressionSyntaxToken' do
    sql = 'SELECT * FROM orders'
    token = Lkml::ExpressionSyntaxToken.new(sql, prefix: ' ', suffix: ' # A comment', expr_suffix: ' ')
    expect(token.to_s).to eq(' SELECT * FROM orders ;; # A comment')
  end
end

RSpec.describe 'PairNode' do
  it 'returns formatted string' do
    node = Lkml::PairNode.new(Lkml::SyntaxToken.new('foo'), Lkml::SyntaxToken.new('bar'))
    expect(node.to_s).to eq('foo: bar')

    node = Lkml::PairNode.new(Lkml::SyntaxToken.new('foo', suffix: ' '), Lkml::SyntaxToken.new('bar'))
    expect(node.to_s).to eq('foo : bar')
  end

  it 'does not have children' do
    node = Lkml::PairNode.new(Lkml::SyntaxToken.new('foo'), Lkml::SyntaxToken.new('bar'))
    expect(node.children).to be_nil
  end
end

RSpec.describe 'ListNode' do
  it 'returns formatted string' do
    node = Lkml::ListNode.new(
      Lkml::SyntaxToken.new('filters'),
      items: [
        Lkml::PairNode.new(Lkml::SyntaxToken.new('created_date'), Lkml::QuotedSyntaxToken.new('7 days')),
        Lkml::PairNode.new(Lkml::SyntaxToken.new('user.status', prefix: ' '), Lkml::QuotedSyntaxToken.new('-disabled'))
      ],
      left_bracket: Lkml::LeftBracket.new,
      right_bracket: Lkml::RightBracket.new
    )
    expect(node.to_s).to eq('filters: [created_date: "7 days", user.status: "-disabled"]')

    node = Lkml::ListNode.new(
      Lkml::SyntaxToken.new('fields'),
      items: [
        Lkml::SyntaxToken.new('user.user_id', prefix: "\n  "),
        Lkml::SyntaxToken.new('user.age', prefix: "\n  ", suffix: "\n")
      ],
      left_bracket: Lkml::LeftBracket.new,
      right_bracket: Lkml::RightBracket.new
    )
    expect(node.to_s).to eq("fields: [\n  user.user_id,\n  user.age\n]")

    node = Lkml::ListNode.new(
      Lkml::SyntaxToken.new('fields'),
      items: [],
      left_bracket: Lkml::LeftBracket.new,
      right_bracket: Lkml::RightBracket.new
    )
    expect(node.to_s).to eq('fields: []')
  end
end

RSpec.describe 'BlockNode' do
  it 'returns formatted string' do
    node = Lkml::BlockNode.new(
      Lkml::SyntaxToken.new('set'),
      name: Lkml::SyntaxToken.new('user_dimensions'),
      left_brace: Lkml::LeftCurlyBrace.new(prefix: ' ', suffix: ' '),
      container: Lkml::ContainerNode.new([
                                           Lkml::ListNode.new(
                                             Lkml::SyntaxToken.new('fields'),
                                             items: [
                                               Lkml::SyntaxToken.new('user.user_id'),
                                               Lkml::SyntaxToken.new('user.age', prefix: ' ')
                                             ],
                                             left_bracket: Lkml::LeftBracket.new,
                                             right_bracket: Lkml::RightBracket.new
                                           )
                                         ]),
      right_brace: Lkml::RightCurlyBrace.new(prefix: ' ')
    )
    expect(node.to_s).to eq('set: user_dimensions { fields: [user.user_id, user.age] }')

    node = Lkml::BlockNode.new(
      Lkml::SyntaxToken.new('set'),
      name: Lkml::SyntaxToken.new('foo'),
      left_brace: Lkml::LeftCurlyBrace.new(prefix: ' '),
      container: [],
      right_brace: Lkml::RightCurlyBrace.new
    )
    expect(node.to_s).to eq('set: foo {}')
  end
end

RSpec.describe 'ContainerNode' do
  it 'returns formatted string' do
    node = Lkml::ContainerNode.new([
                                     Lkml::PairNode.new(Lkml::SyntaxToken.new('hidden'), Lkml::SyntaxToken.new('true')),
                                     Lkml::BlockNode.new(
                                       Lkml::SyntaxToken.new('set', prefix: ' '),
                                       name: Lkml::SyntaxToken.new('foo'),
                                       left_brace: Lkml::LeftCurlyBrace.new(prefix: ' '),
                                       container: [],
                                       right_brace: Lkml::RightCurlyBrace.new
                                     ),
                                     Lkml::ListNode.new(
                                       Lkml::SyntaxToken.new('fields', prefix: ' '),
                                       items: [],
                                       left_bracket: Lkml::LeftBracket.new,
                                       right_bracket: Lkml::RightBracket.new
                                     )
                                   ])
    expect(node.to_s).to eq('hidden: true set: foo {} fields: []')
  end
end

RSpec.describe 'SyntaxToken with trivia' do # rubocop:disable RSpec/DescribeClass
  it 'renders correctly' do
    token = Lkml::SyntaxToken.new('foo', prefix: "# Skip this\n  ")
    expect(token.to_s).to eq("# Skip this\n  foo")

    token = Lkml::SyntaxToken.new('foo', suffix: "\n# Skip this\n  ")
    expect(token.to_s).to eq("foo\n# Skip this\n  ")

    token = Lkml::SyntaxToken.new('foo', prefix: "\n\t", suffix: "\t\n")
    expect(token.to_s).to eq("\n\tfoo\t\n")
  end
end

RSpec.describe 'LookMlVisitor' do
  it 'visits SyntaxToken correctly' do
    visitor = Lkml::LookMlVisitor.new
    token = Lkml::SyntaxToken.new('foo', suffix: "\n")
    expect(visitor.visit_token(token)).to eq("foo\n")
  end
end
