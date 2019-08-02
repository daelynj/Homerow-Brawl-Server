require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayersRooms do
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
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end
  let(:fetch_player_room_records) do
    described_class.new(repository: repository)
  end

  before do
    create_player_room_record.call(player_id: player_1.id, room_id: room.id)
    create_player_room_record.call(player_id: player_2.id, room_id: room.id)
  end

  context 'when the player_room association exists' do
    subject { fetch_player_room_records.call(room_id: room.id) }

    it 'succeeds' do
      expect(subject.successful?).to be(true)
    end

    it 'fetches all player_room records with the specified room' do
      expect(subject.player_room_records.length).to eq(2)

      expect(subject.player_room_records[0].player_id).to eq(player_1.id)
      expect(subject.player_room_records[0].room_id).to eq(room.id)

      expect(subject.player_room_records[1].player_id).to eq(player_2.id)
      expect(subject.player_room_records[1].room_id).to eq(room.id)
    end
  end
end
