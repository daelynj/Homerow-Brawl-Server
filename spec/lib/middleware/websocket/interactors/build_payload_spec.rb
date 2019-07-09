require 'spec_helper'

RSpec.describe Websocket::Interactor::BuildPayload do
  let(:client_1) { Websocket::Client.new(connection_client: nil) }
  let(:client_2) { Websocket::Client.new(connection_client: nil) }
  let(:clients) { [client_1, client_2] }
  let(:build_payload) { described_class.new(clients: clients) }

  describe '#perform_build' do
    subject { build_payload.perform_build }

    it 'builds a json payload' do
      expect(subject).to eq('{"players":[{"position":0},{"position":0}]}')
    end
  end
end
