require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:env_1) { { 'PATH_INFO' => '/1' } }
  let(:env_2) { { 'PATH_INFO' => '/2' } }
  let(:connection_1) { double('connection', env: env_1).as_null_object }
  let(:connection_2) { double('connection', env: env_1).as_null_object }
  let(:connection_3) { double('connection', env: env_2).as_null_object }
  let(:connection_4) { double('connection', env: env_2).as_null_object }
  let(:controller) { described_class.new }

  describe '#on_open' do
    before do
      controller.on_open(connection_1)
      controller.on_open(connection_2)
      controller.on_open(connection_3)
      controller.on_open(connection_4)
    end
    it 'appends a Client to the client list' do
      expect(controller.clients[0].connection).to eq(connection_1)
      expect(controller.clients[1].connection).to eq(connection_2)
    end

    it 'updates the clients in the connecting clients room using the write method' do
      expect(controller.clients[0].connection).to receive(:write)
      expect(controller.clients[1].connection).to receive(:write)
      expect(controller.clients[2].connection).not_to receive(:write)
      expect(controller.clients[3].connection).not_to receive(:write)

      controller.on_open(connection_1)
      controller.on_open(connection_2)
    end
  end

  describe '#on_open room generation' do
    context "the room being joined doesn't exist" do
      before { controller.on_open(connection_1) }

      it 'generates a new room' do
        expect(controller.rooms.length).to eq(1)
      end
    end

    context 'the rooms being joined exist' do
      let(:room_1) { Websocket::Room.new(id: 1) }

      before do
        controller.rooms << room_1
        controller.on_open(connection_1)
        controller.on_open(connection_2)
      end

      it 'adds the client to the room' do
        expect(controller.clients[0].room_id).to eq(1)
        expect(controller.clients[1].room_id).to eq(1)
        expect(controller.rooms[0].id).to eq(1)
        expect(controller.rooms[0].clients.length).to eq(2)
      end
    end
  end

  describe '#on_message' do
    let(:data) { '{"position":33.33333333333333}' }
    subject { controller.on_message(connection_1, data) }

    before do
      controller.on_open(connection_1)
      controller.on_open(connection_2)
      controller.on_open(connection_3)
      controller.on_open(connection_4)
    end

    it 'updates the client position' do
      subject
      expect(controller.clients.first.position).to eq(33.33333333333333)
    end

    it 'updates the clients in the connecting clients room with the status of the race' do
      expect(controller.clients[0].connection).to receive(:write)
      expect(controller.clients[1].connection).to receive(:write)
      expect(controller.clients[2].connection).not_to receive(:write)
      expect(controller.clients[3].connection).not_to receive(:write)
      subject
    end
  end

  describe '#on_close' do
    subject { controller.on_close(connection_1) }

    before { controller.on_open(connection_1) }

    it 'removes the incoming client from the client list' do
      subject
      clients = controller.clients

      expect(clients.length).to eq(0)
    end
  end
end
