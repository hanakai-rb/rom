# frozen_string_literal: true

require 'rom/relation'
require 'rom/command_proxy'

RSpec.describe ROM::Relation, '#command' do
  subject(:relation) do
    ROM::Relation.new([], name: ROM::Relation::Name[:users], commands: commands, auto_map: false)
  end

  let(:commands) do
    {}
  end

  context 'when command is already registered' do
    before do
      commands[:my_command] = custom_command
    end

    context 'when command is not restrictible' do
      let(:custom_command) do
        double(:command, restrictible?: false)
      end

      it 'returns the command if it exists in the registry already' do
        expect(relation.command(:my_command)).to be(custom_command)
      end
    end

    context 'when command is restrictible' do
      let(:custom_command) do
        double(:command, restrictible?: true)
      end

      it 'returns the command if it exists in the registry already' do
        expect(custom_command).to receive(:new).with(relation).and_return(custom_command)

        expect(relation.command(:my_command)).to be(custom_command)
      end
    end
  end

  context 'when command is a graph with a restrictable root' do
    let(:graph) { ROM::CommandProxy.new(double(:graph, restrictible?: true), :user) }

    before do
      commands[:create] = graph
    end

    it 'returns the graph as it is' do
      expect(relation.command(:create)).to be(graph)
    end
  end
end
