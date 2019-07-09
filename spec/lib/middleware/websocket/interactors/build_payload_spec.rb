require 'spec_helper'

RSpec.describe Websocket::Interactor::BuildPayload do
  let(:client_1) { Websocket::Client.new(connection_client: nil, client_id: 1) }
  let(:client_2) { Websocket::Client.new(connection_client: nil, client_id: 2) }
  let(:clients) { [client_1, client_2] }
  let(:build_payload) { described_class.new(clients: clients) }

  describe '#perform_build' do
    subject { build_payload.perform_build }

    it 'builds a json payload' do
      expect(subject).to eq(
        '{"players":[{"id":1,"position":"0%"},{"id":2,"position":"0%"}]}'
      )
    end
  end
end
