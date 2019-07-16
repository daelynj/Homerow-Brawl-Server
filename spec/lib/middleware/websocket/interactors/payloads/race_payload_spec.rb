require 'spec_helper'

RSpec.describe Websocket::Interactor::RacePayload do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:clients) { [client_1, client_2] }

  describe '#call' do
    subject { described_class.new.call(clients: clients) }

    before do
      allow(client_2.player).to receive(:id)
      allow(client_1.player).to receive(:id)
    end

    it 'builds a json payload' do
      expect(subject).to eq(
        '{"players":[{"id":null,"position":0},{"id":null,"position":0}]}'
      )
    end
  end
end