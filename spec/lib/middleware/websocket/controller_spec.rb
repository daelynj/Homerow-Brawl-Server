require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:connection_1) { double('connection').as_null_object }
  let(:connection_2) { double('connection').as_null_object }
  let(:controller) { described_class.new }

  describe '#on_open' do
    before do
      controller.on_open(connection_1)
      controller.on_open(connection_2)
    end

    it 'appends a Client to the client list' do
      expect(controller.clients[0].connection).to eq(connection_1)
      expect(controller.clients[1].connection).to eq(connection_2)
    end

    it 'updates all clients using the write method' do
      expect(controller.clients[0].connection).to receive(:write)
      expect(controller.clients[1].connection).to receive(:write)

      controller.on_open(connection_1)
      controller.on_open(connection_2)
    end
  end

  describe '#on_message' do
    let(:data) { '{"position":33.33333333333333}' }
    subject { controller.on_message(connection_1, data) }

    before { controller.on_open(connection_1) }

    it 'updates the client position' do
      subject
      expect(controller.clients.first.position).to eq(33.33333333333333)
    end

    it 'updates all clients with the status of the race' do
      expect(controller.clients.first.connection).to receive(:write)
      subject
    end
  end

  describe '#on_close' do
    subject { controller.on_close(connection_2) }

    before do
      controller.on_open(connection_1)
      controller.on_open(connection_2)
    end

    it 'removes the incoming client from the client list' do
      subject
      clients = controller.clients

      expect(clients.length).to eq(1)
      expect(clients.first.connection).to eq(connection_1)
    end

    it 'updates all clients using the write method' do
      expect(controller.clients[0].connection).to receive(:write)
      subject
    end
  end
end
