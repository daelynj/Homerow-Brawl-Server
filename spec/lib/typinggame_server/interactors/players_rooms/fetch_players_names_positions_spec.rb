require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayersNamesPositions do
  let(:player_attributes) { { 'id' => 1, 'name' => 'octane' } }
  let(:team) { { 'id' => 'X0klA3' } }
  let(:access_token) { 'fdgdfg908g9n9gf09fgh8' }
  let(:player) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes,
      team: team,
      access_token: access_token
    )
      .player
  end
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayerRoomRepository.new }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end
  let(:fetch_players_names_positions_record) do
    described_class.new(repository: repository)
  end

  describe '#call' do
    subject do
      fetch_players_names_positions_record.call(room_id: room.id)
        .players_names_positions
        .first
    end

    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    it 'joins the record for the specified room and player' do
      expect(subject[:name]).to eq('octane')
      expect(subject[:position]).to eq(0)
      expect(subject[:player_id]).to eq(player.id)
    end
  end
end
