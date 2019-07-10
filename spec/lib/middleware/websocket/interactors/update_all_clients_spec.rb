require 'spec_helper'

RSpec.describe Websocket::Interactor::UpdateAllClients do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:clients) { [client_1, client_2] }
  let(:update_all_clients) { described_class.new }

  describe '#perform_update' do
    subject { update_all_clients.call(clients: clients) }

    it 'calls the write method for each client' do
      update_all_clients
      expect(client_1.connection).to receive(:write)
      expect(client_2.connection).to receive(:write)
      subject
    end
  end
end
