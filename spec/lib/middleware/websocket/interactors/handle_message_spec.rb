require 'spec_helper'

RSpec.describe Websocket::Interactor::HandleMessage do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:env) { { 'PATH_INFO' => "/#{room.id}" } }
  let(:connection) { double('connection', env: env) }
  let(:handle_message) { described_class.new }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end

  describe '#call' do
    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    context 'when the client sends a position update' do
      let(:data) { { 'id' => player.id, 'position' => 30 } }
      subject { handle_message.call(data: data, connection: connection) }

      it 'updates the players position' do
        allow(connection).to receive(:publish)

        subject

        player_room_record =
          Interactors::PlayersRooms::FetchPlayerRoom.new.call(
            player_id: player.id, room_id: room.id
          )
            .player_room_record

        expect(player_room_record.position).to eq(30)
      end

      it 'sends all players in the room a race update' do
        expect(connection).to receive(:publish).with(
          "#{room.id}",
          "{\"players\":[{\"id\":#{player.id},\"position\":30}]}"
        )

        subject
      end
    end

    context 'when a player sends a countdown update' do
      let(:data) { { 'countdown' => true } }

      subject { handle_message.call(data: data, connection: connection) }

      it 'sends all players in the room a countdown update' do
        expect(connection).to receive(:publish).with(
          "#{room.id}",
          '{"countdown":true}'
        )

        subject
      end
    end
  end
end
