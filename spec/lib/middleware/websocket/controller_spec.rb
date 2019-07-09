require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:incoming_client_1) { double }
  let(:incoming_client_2) { double }
  let (:controller) do
    described_class.new
  end

  describe '#on_open' do
    subject { controller.on_open(incoming_client_1) }

    it 'generates a Client' do
      expect(subject.first).to be_kind_of(Websocket::Client)
    end

    it 'appends a Client to the client list' do
      subject
      client = controller.clients.first

      expect(client.connection_client).to eq(incoming_client_1)
    end
  end

  describe '#on_close' do
    subject { controller.on_close(incoming_client_2) }

    it 'removes the closing client from the list of clients' do
      controller.on_open(incoming_client_1)
      controller.on_open(incoming_client_2)
      subject

      clients = controller.clients

      expect(clients.length).to eq(1)
      expect(clients.first.connection_client).to eq(incoming_client_1)
    end
  end
end
