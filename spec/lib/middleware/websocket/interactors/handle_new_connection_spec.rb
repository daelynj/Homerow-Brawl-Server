RSpec.describe Websocket::Interactor::HandleNewConnection do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:create_players_rooms) do
    Interactors::PlayersRooms::CreatePlayersRooms.new
  end
  let(:env) { { 'PATH_INFO' => "/#{room.id}" } }
  let(:connection) { double('connection', env: env) }
  let(:handle_new_connection) { described_class.new }

  describe '#call' do
    subject { handle_new_connection.call(connection: connection) }

    before { create_players_rooms.call(player_id: player.id, room_id: room.id) }

    it 'subscribes a new connection to a room' do
      allow(connection).to receive(:publish)
      allow(connection).to receive(:write)

      expect(connection).to receive(:subscribe).with("#{room.id}")
      subject
    end

    it 'builds an association between the player and the room' do
      allow(connection).to receive(:publish)
      allow(connection).to receive(:write)
      allow(connection).to receive(:subscribe)

      subject

      room_information =
        Interactors::PlayersRooms::FetchPlayersRooms.new.call(room_id: room.id)
          .room_information
      expect(room_information.length).to eq(2)
      expect(room_information[0].room_id).to eq(room.id)
    end

    it 'performs a player creation update' do
      allow(connection).to receive(:subscribe)
      allow(connection).to receive(:publish)

      expect(connection).to receive(:write).with("{\"id\":#{player.id + 1}}")
      subject
    end

    it 'performs a race update' do
      allow(connection).to receive(:write)
      allow(connection).to receive(:subscribe)

      expect(connection).to receive(:publish).with(
        "#{room.id}",
        "{\"players\":[{\"id\":#{player.id},\"position\":0},{\"id\":#{
          player.id + 1
        },\"position\":0}]}"
      )
      subject
    end
  end
end
