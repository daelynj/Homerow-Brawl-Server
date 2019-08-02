require 'spec_helper'

RSpec.describe PlayerRoomRepository, type: :repository do
  let(:player_attributes_1) { { 'id' => 1, 'name' => 'octane' } }
  let(:team_1) { { 'id' => 'X0rlA1' } }
  let(:access_token_1) { 'fdgdfg934kdn9gf09fgh8' }

  let(:player_attributes_2) { { 'id' => 2, 'name' => 'dominus' } }
  let(:team_2) { { 'id' => 'X0klA3' } }
  let(:access_token_2) { 'fdgdfg908g9n9gf09fgh8' }

  let(:player_1) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes_1,
      team: team_1,
      access_token: access_token_1
    )
      .player
  end
  let(:player_2) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes_2,
      team: team_2,
      access_token: access_token_2
    )
      .player
  end
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayerRoomRepository.new }
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

  describe '#find_players_names_positions' do
    subject { repository.find_players_names_positions(room_id: room.id) }

    before do
      create_player_room.call(player_id: player_1.id, room_id: room.id)
      create_player_room.call(player_id: player_2.id, room_id: room.id)
    end

    it 'joins the players table and player_rooms table' do
      expect(subject).to eq(
        [
          { name: 'octane', player_id: player_1.id, position: 0 },
          { name: 'dominus', player_id: player_2.id, position: 0 }
        ]
      )
    end
  end
end
