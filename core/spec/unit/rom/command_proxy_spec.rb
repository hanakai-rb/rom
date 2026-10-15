# frozen_string_literal: true

require 'rom/command_proxy'

RSpec.describe ROM::CommandProxy do
  subject(:proxy) { ROM::CommandProxy.new(graph, :user) }

  let(:graph) { double(:graph, restrictible?: true) }

  describe '#restrictible?' do
    it 'is false even when the root command is restrictable' do
      expect(proxy).not_to be_restrictible
    end
  end
end
