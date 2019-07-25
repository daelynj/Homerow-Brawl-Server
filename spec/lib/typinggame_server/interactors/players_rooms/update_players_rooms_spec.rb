require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::UpdatePlayersRooms do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:data) { { 'id' => player.id, 'position' => 30 } }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_players_rooms_record) do
    Interactors::PlayersRooms::CreatePlayersRooms.new
  end
  let(:update_players_rooms_record) do
    described_class.new(repository: repository)
  end

  context 'when the player and room exist' do
    subject { update_players_rooms_record.call(data: data, room_id: room.id) }

    before do
      create_players_rooms_record.call(player_id: player.id, room_id: room.id)
    end

    it 'succeeds' do
      expect(subject.successful?).to be(true)
    end

    it 'updates the player position specified in the data and room' do
      expect(subject.updated_players_rooms_record.player_id).to eq(player.id)
      expect(subject.updated_players_rooms_record.room_id).to eq(room.id)
      expect(subject.updated_players_rooms_record.position).to eq(30)
    end
  end
end
