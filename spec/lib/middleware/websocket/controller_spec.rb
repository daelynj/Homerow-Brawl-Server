require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:incoming_client_1) { double(write: nil) }
  let(:incoming_client_2) { double(write: nil) }
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

    before do
      controller.on_open(incoming_client_1)
      controller.on_open(incoming_client_2)
    end

    it 'removes the closing client from the list of clients' do
      subject

      clients = controller.clients

      expect(clients.length).to eq(1)
      expect(clients.first.connection_client).to eq(incoming_client_1)
    end
  end

  describe '#build_payload' do
    subject { controller.build_payload }

    before do
      controller.on_open(incoming_client_1)
      controller.on_open(incoming_client_2)
    end

    it 'builds the expected payload' do
      expected_JSON = '{"players":[{"position":0},{"position":0}]}'

      expect(subject).to eq(expected_JSON)
    end
  end

  describe '#find_client' do
    subject { controller.find_client(incoming_client_2) }

    before do
      controller.on_open(incoming_client_1)
      controller.on_open(incoming_client_2)
    end

    it 'returns the requested client' do
      expect(subject.first).to eq(controller.clients[1])
    end
  end

  describe '#update_all_clients' do
    subject { controller.update_all_clients }

    before do
      controller.on_open(incoming_client_1)
      controller.on_open(incoming_client_2)
    end

    it 'calls the write method on each client' do
      expect(incoming_client_1).to receive(:write)
      expect(incoming_client_2).to receive(:write)
      subject
    end
  end
end
