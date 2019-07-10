require 'spec_helper'

RSpec.describe Websocket::Interactor::BuildPayload do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:clients) { [client_1, client_2] }

  describe '#call' do
    subject { described_class.new.call(clients: clients) }

    it 'builds a json payload' do
      expect(subject).to eq('{"players":[{"position":0},{"position":0}]}')
    end
  end
end
