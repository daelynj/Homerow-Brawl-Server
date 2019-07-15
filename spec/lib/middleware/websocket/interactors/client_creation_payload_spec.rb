require 'spec_helper'

RSpec.describe Websocket::Interactor::ClientCreationPayload do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:clients) { [client_1, client_2] }

  describe '#call' do
    subject { described_class.new.call(client: client_1) }

    before do
      allow(client_1.player).to receive(:id)
      allow(client_1.player).to receive(:token)
    end

    it 'builds a json payload' do
      expect(subject).to eq('{"token":null,"id":null}')
    end
  end
end
