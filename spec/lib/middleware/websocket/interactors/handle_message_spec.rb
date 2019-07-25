require 'spec_helper'

RSpec.describe Websocket::Interactor::HandleMessage do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:env) { { 'PATH_INFO' => "/#{room.id}" } }
  let(:connection) { double('connection', env: env) }
  let(:handle_message) { described_class.new }
  let(:create_players_rooms) do
    Interactors::PlayersRooms::CreatePlayersRooms.new
  end

  describe '#call' do
    before { create_players_rooms.call(player_id: player.id, room_id: room.id) }

    context 'when the client sends a position update' do
      let(:data) { { 'id' => player.id, 'position' => 30 } }
      subject { handle_message.call(data: data, connection: connection) }

      it 'updates the players position' do
        allow(connection).to receive(:publish)

        subject

        room_information =
          Interactors::PlayersRooms::FetchPlayersRooms.new.call(
            room_id: room.id
          )
            .room_information

        expect(room_information[0].position).to eq(30)
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
