require 'spec_helper'

RSpec.describe Websocket::Interactor::UpdateAllClients do
  let(:client_1) do
    Websocket::Client.new(connection_client: double('client').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection_client: double('client').as_null_object)
  end
  let(:clients) { [client_1, client_2] }
  let(:update_all_clients) { described_class.new(clients: clients) }

  describe '#perform_update' do
    subject { update_all_clients.perform_update }

    it 'calls the write method for each client' do
      update_all_clients
      expect(client_1.connection_client).to receive(:write)
      expect(client_2.connection_client).to receive(:write)
      subject
    end
  end

  describe '#generate_payload' do
    let(:expected_payload) { '{"players":[{"position":0},{"position":0}]}' }
    subject { update_all_clients.generate_payload }

    it 'receives a payload' do
      expect(subject).to eq(expected_payload)
    end
  end
end
