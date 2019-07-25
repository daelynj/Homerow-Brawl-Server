RSpec.describe PlayersRoomsRepository, type: :repository do
  let(:player_1) { Interactors::Players::CreatePlayer.new.call.player }
  let(:player_2) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_player_room) { Interactors::PlayersRooms::CreatePlayerRoom.new }

  describe '#find_players_rooms_records' do
    context 'retrieving players_rooms_records with a room_id' do
      subject { repository.find_player_room_records(room_id: room.id) }

      before do
        create_player_room.call(player_id: player_1.id, room_id: room.id)
        create_player_room.call(player_id: player_2.id, room_id: room.id)
      end

      it 'returns an array of all players_rooms rows with given room_id' do
        expect(subject[0].player_id).to eq(player_1.id)
        expect(subject[0].room_id).to eq(room.id)

        expect(subject[1].player_id).to eq(player_2.id)
        expect(subject[1].room_id).to eq(room.id)
      end
    end

    context 'retrieving a players_rooms_record with a player_id and room_id' do
      subject do
        repository.find_player_room_records(
          player_id: player_1.id, room_id: room.id
        )
      end

      before do
        create_player_room.call(player_id: player_1.id, room_id: room.id)
      end

      it 'returns one players_rooms row with given room_id and player_id' do
        expect(subject.player_id).to eq(player_1.id)
        expect(subject.room_id).to eq(room.id)
      end
    end
  end
end
