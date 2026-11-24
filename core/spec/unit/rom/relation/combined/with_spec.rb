# frozen_string_literal: true

require 'rom/relation/combined'

RSpec.describe ROM::Relation::Combined, '#with' do
  subject(:relation) do
    ROM::Relation::Combined.new(users, [tasks])
  end

  let(:users) do
    ROM::Relation.new([])
  end

  let(:tasks) do
    ROM::Relation.new([])
  end

  it 'returns a new graph with the options applied to its root' do
    new_graph = relation.with(auto_struct: true)

    expect(new_graph).to be_instance_of(ROM::Relation::Combined)
    expect(new_graph.root.options[:auto_struct]).to be(true)
    expect(new_graph.nodes.size).to be(1)
  end

  it 'returns self when no options are given' do
    expect(relation.with).to be(relation)
  end
end
