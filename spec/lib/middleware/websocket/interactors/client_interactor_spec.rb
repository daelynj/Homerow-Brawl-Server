require 'spec_helper'

RSpec.describe Websocket::Interactor::ClientInteractor do
  let(:client_interactor) { described_class.new }
  let(:client_1) { double }
  let(:client_2) { double }

  describe '#create_client' do
    subject { client_interactor.create_client(incoming_client: client_1) }

    it 'appends a Client to the client list' do
      subject
      client = client_interactor.clients.first

      expect(client.connection_client).to eq(client_1)
    end

    it 'assigns an incremental ID to an incoming client' do
      subject
      client_interactor.create_client(incoming_client: client_2)
      clients = client_interactor.clients

      expect(clients[0].client_attributes['id']).to eq(1)
      expect(clients[1].client_attributes['id']).to eq(2)
    end
  end

  describe '#delete_client' do
    subject { client_interactor.delete_client(incoming_client: client_2) }

    it 'removes the incoming client from the client list' do
      client_interactor.create_client(incoming_client: client_1)
      client_interactor.create_client(incoming_client: client_2)
      subject

      clients = client_interactor.clients

      expect(clients.length).to eq(1)
      expect(clients.first.connection_client).to eq(client_1)
    end
  end

  describe '#find_client' do
    subject { client_interactor.find_client(incoming_client: client_2) }

    it 'returns the incoming client' do
      client_interactor.create_client(incoming_client: client_1)
      client_interactor.create_client(incoming_client: client_2)

      expect(subject.first).to eq(client_interactor.clients[1])
    end
  end

  describe '#update_all_clients' do
    subject { client_interactor.update_all_clients }

    it 'calls the service object for updating all the connected clients' do
      expect(subject).to be_kind_of(Websocket::Interactor::UpdateAllClients)
    end
  end
end
