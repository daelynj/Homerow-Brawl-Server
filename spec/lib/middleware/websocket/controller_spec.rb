require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:env) { { 'PATH_INFO' => "/#{room.id}" } }
  let(:connection) { double('connection', env: env) }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end

  describe '#on_open' do
    subject { described_class.new.on_open(connection) }

    it 'handles the new connection' do
      expect(connection).to receive(:subscribe)
      expect(connection).to receive(:publish)
      expect(connection).to receive(:write)

      subject
    end
  end

  describe '#on_message' do
    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    context 'race update' do
      let(:data) { { 'id' => player.id, 'position' => 30 }.to_json }

      subject { described_class.new.on_message(connection, data) }

      it 'handles the message' do
        expect(connection).to receive(:publish)
        subject
      end
    end

    context 'countdown update' do
      let(:data) { { 'countdown' => true }.to_json }

      subject { described_class.new.on_message(connection, data) }

      it 'handles the message' do
        expect(connection).to receive(:publish)
        subject
      end
    end
  end
end
