# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Lkml::DictParser do
  let(:parser) { described_class.new }

  it 'parses token with unquoted literal' do
    token = parser.parse_token('hidden', 'no')
    result = token.to_s
    expect(result).to eq('no')
  end

  it 'parses token with quoted literal' do
    token = parser.parse_token('label', 'Dimension Name')
    result = token.to_s
    expect(result).to eq('"Dimension Name"')
  end

  it 'parses pair with unquoted literal' do
    node = parser.parse_pair('hidden', 'no')
    result = node.to_s
    expect(result).to eq('hidden: no')
  end

  it 'parses pair with quoted literal' do
    node = parser.parse_pair('label', 'Dimension Name')
    result = node.to_s
    expect(result).to eq('label: "Dimension Name"')
  end

  it 'parses list with unquoted literals' do
    node = parser.parse_list('fields', %w[dimension_one dimension_two dimension_three])
    result = node.to_s
    expect(result).to eq('fields: [dimension_one, dimension_two, dimension_three]')
  end

  it 'parses list with quoted literals' do
    node = parser.parse_list('sortkeys', %w[column_one column_two column_three])
    result = node.to_s
    expect(result).to eq('sortkeys: ["column_one", "column_two", "column_three"]')
  end

  it 'parses list with many values' do
    node = parser.parse_list(
      'timeframes',
      %w[
        raw time hour_of_day date day_of_week week month quarter year
      ]
    )
    result = node.to_s
    expect(result).to eq(
      "timeframes: [\n  " \
      "raw,\n  " \
      "time,\n  " \
      "hour_of_day,\n  " \
      "date,\n  " \
      "day_of_week,\n  " \
      "week,\n  " \
      "month,\n  " \
      "quarter,\n  " \
      "year,\n" \
      ']'
    )
  end

  it 'parses list with no values' do
    node = parser.parse_list('sortkeys', [])
    result = node.to_s
    expect(result).to eq('sortkeys: []')
  end

  it 'parses block with unquoted literals' do
    node = parser.parse_block(
      'bind_fields', { 'from_field' => 'field_name', 'to_field' => 'field_name' }
    )
    result = node.to_s
    expect(result).to eq(
      "bind_fields: {\n  " \
      "from_field: field_name\n  " \
      "to_field: field_name\n" \
      '}'
    )
  end

  it 'parses block with quoted literals' do
    node = parser.parse_block(
      'dimension',
      {
        'label' => 'Dimension Name',
        'group_label' => 'Group Name',
        'description' => 'A dimension description.'
      }
    )
    result = node.to_s
    expect(result).to eq(
      "dimension: {\n  " \
      "label: \"Dimension Name\"\n  " \
      "group_label: \"Group Name\"\n  " \
      "description: \"A dimension description.\"\n" \
      '}'
    )
  end

  it 'parses block with name' do
    node = parser.parse_block(
      'dimension', { 'label' => 'Dimension Name' }, name: 'dimension_name'
    )
    result = node.to_s
    expect(result).to eq(
      "dimension: dimension_name {\n  " \
      "label: \"Dimension Name\"\n" \
      '}'
    )
  end

  it 'parses block with no fields and name' do
    node = parser.parse_block('dimension', {}, name: 'dimension_name')
    result = node.to_s
    expect(result).to eq('dimension: dimension_name {}')
  end

  it 'parses block with no fields and no name' do
    node = parser.parse_block('dimension', {}, name: nil)
    result = node.to_s
    expect(result).to eq('dimension: {}')
  end

  it 'parses nested block' do
    node = parser.parse_block(
      'derived_table',
      {
        'explore_source' => {
          'bind_filters' => { 'from_field' => 'field_name', 'to_field' => 'field_name' },
          'name' => 'explore_name'
        }
      }
    )
    result = node.to_s
    expect(result).to eq(
      "derived_table: {\n  " \
      "explore_source: explore_name {\n    " \
      "bind_filters: {\n      " \
      "from_field: field_name\n      " \
      "to_field: field_name\n    " \
      "}\n  " \
      "}\n" \
      '}'
    )
  end

  it 'parses any with str value' do
    node = parser.parse_any('hidden', 'yes')
    result = node.to_s
    expect(result).to eq('hidden: yes')
  end

  it 'parses any with list value' do
    node = parser.parse_any('sortkeys', %w[column_one column_two])
    result = node.to_s
    expect(result).to eq('sortkeys: ["column_one", "column_two"]')
  end

  it 'parses any with dict value and name' do
    node = parser.parse_any(
      'dimension', { 'name' => 'dimension_name', 'label' => 'Dimension Name' }
    )
    result = node.to_s
    expect(result).to eq(
      "dimension: dimension_name {\n  " \
      "label: \"Dimension Name\"\n" \
      '}'
    )
  end

  it 'parses any with dict value and no name' do
    node = parser.parse_any('dimension', { 'label' => 'Dimension Name' })
    result = node.to_s
    expect(result).to eq(
      "dimension: {\n  " \
      "label: \"Dimension Name\"\n" \
      '}'
    )
  end

  it 'raises error with bad type' do
    expect { parser.parse_any('sql', 100) }.to raise_error(TypeError)
  end

  it 'expands list with blocks' do
    nodes = parser.expand_list(
      'dimensions', [{ 'name' => 'dimension_one' }, { 'name' => 'dimension_two' }]
    )
    result = nodes.map(&:to_s).join
    expect(result).to eq("dimension: dimension_one {}\n\ndimension: dimension_two {}")
  end

  it 'expands list with pairs' do
    nodes = parser.expand_list(
      'includes', %w[filename_or_pattern_one filename_or_pattern_two]
    )
    result = nodes.map(&:to_s).join
    expect(result).to eq(
      "include: \"filename_or_pattern_one\"\ninclude: \"filename_or_pattern_two\""
    )
  end

  it 'parses top level pairs' do
    obj = {
      'connection' => 'c53-looker',
      'includes' => ['*.view'],
      'fiscal_month_offset' => '0',
      'week_start_day' => 'sunday'
    }
    node = parser.parse(obj)
    result = node.to_s
    expect(result).to eq(
      "connection: \"c53-looker\"\n" \
      "include: \"*.view\"\n" \
      "fiscal_month_offset: 0\n" \
      'week_start_day: sunday'
    )
  end

  it 'parses query' do
    obj = {
      'queries' => [
        {
          'name' => 'query_one',
          'dimensions' => %w[dimension_one dimension_two],
          'measures' => ['measure_one']
        }
      ]
    }
    node = parser.parse(obj)
    result = node.to_s
    expect(result).to eq(
      "query: query_one {\n  " \
      "dimensions: [dimension_one, dimension_two]\n  " \
      "measures: [measure_one]\n" \
      '}'
    )
  end

  it 'parses query with filters' do
    obj = {
      'explores' => [
        {
          'queries' => [{ 'filters__all' => [[{ 'baz' => 'expression' }, { 'qux' => 'expression' }]],
                          'name' => 'bar' }],
          'name' => 'foo'
        }
      ]
    }
    node = parser.parse(obj)
    result = node.to_s
    expect(result).to eq(
      "explore: foo {\n  " \
      "query: bar {\n    " \
      "filters: [\n      " \
      "baz: \"expression\",\n      " \
      "qux: \"expression\",\n    " \
      "]\n  " \
      "}\n" \
      '}'
    )
  end

  it 'resolves filters filter only field' do
    nodes = parser.resolve_filters(
      [{ 'name' => 'filter_a', 'type' => 'string' }, { 'name' => 'filter_b', 'type' => 'number' }]
    )
    result = nodes.map(&:to_s).join
    expect(result).to eq(
      "filter: filter_a {\n  type: string\n}\n\n" \
      "filter: filter_b {\n  type: number\n}"
    )
  end

  it 'resolves filters legacy filters' do
    nodes = parser.resolve_filters(
      [
        { 'field' => 'dimension_a', 'value' => '-NULL' },
        { 'field' => 'dimension_b', 'value' => '>5' }
      ]
    )
    result = nodes.map(&:to_s).join
    expect(result).to eq(
      "filters: {\n  field: dimension_a\n  value: \"-NULL\"\n}\n\n" \
      "filters: {\n  field: dimension_b\n  value: \">5\"\n}"
    )
  end

  it 'resolves filters new filters' do
    node = parser.resolve_filters([{ 'dimension_a' => '-NULL' }, { 'dimension_b' => '>5' }])
    result = node.to_s
    expect(result).to eq(
      "filters: [\n  " \
      "dimension_a: \"-NULL\",\n  " \
      "dimension_b: \">5\",\n" \
      ']'
    )
  end
end
