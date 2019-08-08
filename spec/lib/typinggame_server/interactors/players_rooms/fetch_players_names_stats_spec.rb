require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayersNamesStats do
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
  let(:fetch_players_names_stats_record) do
    described_class.new(repository: repository)
  end

  describe '#call' do
    subject do
      fetch_players_names_stats_record.call(room_id: room.id)
        .players_names_stats
        .first
    end

    before do
      repository.create(
        player_id: player.id,
        words_typed: 10,
        time: 4,
        mistakes: 2,
        letters_typed: 50,
        room_id: room.id
      )
    end

    it 'joins the record for the specified room and player' do
      expect(subject[:name]).to eq('octane')
      expect(subject[:player_id]).to eq(player.id)
      expect(subject[:words_typed]).to eq(10)
      expect(subject[:time]).to eq(4)
      expect(subject[:mistakes]).to eq(2)
      expect(subject[:letters_typed]).to eq(50)
    end
  end
end
