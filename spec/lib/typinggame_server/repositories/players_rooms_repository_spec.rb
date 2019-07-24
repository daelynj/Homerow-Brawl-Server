RSpec.describe PlayersRoomsRepository, type: :repository do
  let(:player_1) { Interactors::Players::CreatePlayer.new.call.player }
  let(:player_2) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_players_rooms) do
    Interactors::PlayersRooms::CreatePlayersRooms.new
  end

  describe '#find_players_in_room' do
    subject { repository.find_players_in_room(room_id: room.id) }

    before do
      create_players_rooms.call(player_id: player_1.id, room_id: room.id)
      create_players_rooms.call(player_id: player_2.id, room_id: room.id)
    end

    it 'returns an array of all players_rooms rows with given room_id' do
      expect(subject[0].player_id).to eq(player_1.id)
      expect(subject[0].room_id).to eq(room.id)

      expect(subject[1].player_id).to eq(player_2.id)
      expect(subject[1].room_id).to eq(room.id)
    end
  end

  describe '#find_player_in_room' do
    subject do
      repository.find_player_in_room(player_id: player_1.id, room_id: room.id)
    end

    before do
      create_players_rooms.call(player_id: player_1.id, room_id: room.id)
    end

    it 'returns one players_rooms row with given room_id and player_id' do
      expect(subject.player_id).to eq(player_1.id)
      expect(subject.room_id).to eq(room.id)
    end
  end
end
