require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::UpdatePlayersRooms do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:data) { { 'id' => player.id, 'position' => 30 } }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_players_rooms) do
    Interactors::PlayersRooms::CreatePlayersRooms.new
  end
  let(:update_players_rooms) { described_class.new(repository: repository) }

  context 'when the player and room exist' do
    subject { update_players_rooms.call(data: data, room_id: room.id) }

    before { create_players_rooms.call(player_id: player.id, room_id: room.id) }

    it 'succeeds' do
      expect(subject.successful?).to be(true)
    end

    it 'updates the player position specified in the data and room' do
      expect(subject.updated_player.player_id).to eq(player.id)
      expect(subject.updated_player.room_id).to eq(room.id)
      expect(subject.updated_player.position).to eq(30)
    end
  end
end
