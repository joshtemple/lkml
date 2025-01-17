# frozen_string_literal: true

require_relative 'spec_helper'

require 'pathname'

BASE_GITHUB_PATH = Pathname.new(__FILE__).dirname.join('resources/github')
filenames = Dir.glob(BASE_GITHUB_PATH.join('*.lkml')).map { |path| File.basename(path) }

RSpec.describe 'GitHub Files Tests' do # rubocop:disable RSpec/DescribeClass
  filenames.each do |filename|
    context "when testing #{filename}" do
      let(:lookml) do
        File.read(BASE_GITHUB_PATH.join(filename))
      end

      it 'round trip should work' do
        # Load the LookML from file, parsing into a tree
        tree = Lkml.parse(lookml)

        # Verify it hasn't changed once converted back to string
        expect(tree.to_s).to eq(lookml)

        # Convert that parsed tree into a lossy dictionary
        visitor = Lkml::DictVisitor.new
        tree_as_dict = visitor.visit(tree)

        # Parse the dictionary into a new tree
        parser = Lkml::DictParser.new
        new_tree = parser.parse(tree_as_dict)

        # Verify that the string form of the tree parsed from a dictionary can be re-parsed
        Lkml.parse(new_tree.to_s)
      end
    end
  end
end
