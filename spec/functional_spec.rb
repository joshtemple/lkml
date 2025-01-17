# frozen_string_literal: true

require_relative 'spec_helper'

require 'pathname'

RSpec.describe 'Functional Tests' do # rubocop:disable RSpec/DescribeClass
  def load(filename)
    path = Pathname.new(__FILE__).dirname.join('resources', filename)
    text = path.read
    Lkml.parse(text)
  end

  it 'parses block with single quoted field' do
    parsed = load('block_with_single_quoted_field.view.lkml')
    expect(parsed).not_to be_nil
  end

  it 'parses block with multiple quoted fields' do
    parsed = load('block_with_multiple_quoted_fields.view.lkml')
    expect(parsed).not_to be_nil
  end

  it 'removes item from list and serializes sensibly' do
    # Test with only whitespace in between items
    tree = Lkml.parse('name: [a, b, c]')
    node = tree.container.items.first
    expect(node.to_s).to eq('name: [a, b, c]')

    new_items = node.items.reject { |item| item.value == 'b' }
    node.instance_variable_set(:@items, new_items)
    expect(node.to_s).to eq('name: [a, c]')

    node.instance_variable_set(:@items, [])
    expect(node.to_s).to eq('name: []')

    # Test with leading and trailing spaces
    tree = Lkml.parse('name: [ a, b, c ]')
    node = tree.container.items.first
    expect(node.to_s).to eq('name: [ a, b, c ]')

    new_items = node.items.reject { |item| item.value == 'b' }
    node.instance_variable_set(:@items, new_items)
    expect(node.to_s).to eq('name: [ a, c ]')

    node.instance_variable_set(:@items, [])
    expect(node.to_s).to eq('name: []')

    # Test with items on new lines with trailing newline
    tree = Lkml.parse("name: [\n  a,\n  b,\n  c\n]")
    node = tree.container.items.first
    expect(node.to_s).to eq("name: [\n  a,\n  b,\n  c\n]")

    new_items = node.items.reject { |item| item.value == 'b' }
    node.instance_variable_set(:@items, new_items)
    expect(node.to_s).to eq("name: [\n  a,\n  c\n]")

    node.instance_variable_set(:@items, [])
    expect(node.to_s).to eq('name: []')
  end

  it 'parses view with all fields' do
    parsed = load('view_with_all_fields.view.lkml')
    expect(parsed).not_to be_nil
  end

  it 'parses model with all fields' do
    parsed = load('model_with_all_fields.model.lkml')
    expect(parsed).not_to be_nil
  end

  it 'parses duplicate top level keys' do
    parsed = load('duplicate_top_level_keys.view.lkml')
    expect(parsed).not_to be_nil
  end

  it 'raises error for duplicate non-top level keys' do
    expect { load('duplicate_non_top_level_keys.view.lkml') }.to raise_error(KeyError)
  end

  it 'parses lists with comma configurations' do
    parsed = load('lists_with_comma_configurations.view.lkml')
    expect(parsed).not_to be_nil
  end

  it 'parses reserved dimension names' do
    parsed = load('block_with_reserved_dimension_names.view.lkml')
    expect(parsed).not_to be_nil
  end

  it 'ensures repeated dump does not mutate input' do
    text = <<~LOOKML
      view: albums {
          dimension: id {
              primary_key: yes
              type: number
              sql: ${TABLE}.album_id ;;
          }
      }
    LOOKML

    tree = Lkml.parse(text)
    visitor = Lkml::DictVisitor.new
    parsed = visitor.visit(tree)
    first = Lkml.dump(parsed)
    second = Lkml.dump(parsed)
    expect(first).to eq(second)
  end
end
