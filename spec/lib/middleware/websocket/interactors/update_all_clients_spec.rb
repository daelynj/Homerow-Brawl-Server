require 'spec_helper'

RSpec.describe Websocket::Interactor::UpdateAllClients do
  let(:client_1) { double('client').as_null_object }
  let(:client_2) { double('client').as_null_object }
  let(:clients) { [client_1, client_2] }
  let(:update_all_clients) { described_class.new(clients: clients) }

  describe '#perform_update' do
    subject { update_all_clients.perform_update }

    it 'calls the write method for each client' do
      update_all_clients
      expect(client_1).to receive(:write)
      expect(client_2).to receive(:write)
      subject
    end
  end

  describe '#generate_payload' do
    subject { update_all_clients.generate_payload }

    it 'receives a payload' do
      expect(subject).to be_a(String)
    end
  end
end
