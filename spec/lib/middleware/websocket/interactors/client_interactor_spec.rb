require 'spec_helper'

RSpec.describe Websocket::Interactor::ClientInteractor do
  let(:client_interactor) { described_class.new }
  let(:connection_1) { double('connection').as_null_object }
  let(:connection_2) { double('connection').as_null_object }

  describe '#create_client' do
    subject do
      client_interactor.create_client(incoming_connection: connection_1)
    end

    it 'appends a Client to the client list' do
      subject
      client = client_interactor.clients.first

      expect(client.connection).to eq(connection_1)
    end
  end

  describe '#delete_client' do
    subject do
      client_interactor.delete_client(incoming_connection: connection_2)
    end

    before do
      client_interactor.create_client(incoming_connection: connection_1)
      client_interactor.create_client(incoming_connection: connection_2)
    end

    it 'removes the incoming client from the client list' do
      subject

      clients = client_interactor.clients

      expect(clients.length).to eq(1)
      expect(clients.first.connection).to eq(connection_1)
    end
  end

  describe '#update_all_clients' do
    before do
      client_interactor.create_client(incoming_connection: connection_1)
      client_interactor.create_client(incoming_connection: connection_2)
    end
    subject { client_interactor.update_all_clients }

    it 'updates all clients using the write method' do
      client_interactor
      expect(client_interactor.clients[0].connection).to receive(:write)
      expect(client_interactor.clients[1].connection).to receive(:write)
      subject
    end
  end
end
