require 'spec_helper'

RSpec.describe Websocket::Interactor::ClientCreationPayload do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end

  describe '#call' do
    subject { described_class.new.call(client: client_1) }
    before { client_1.generate_player }

    it 'builds a json payload' do
      expect(subject).to eq("{\"id\":#{client_1.player.id}}")
    end
  end
end
