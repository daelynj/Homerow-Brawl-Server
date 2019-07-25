require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::UpdatePlayerRoom do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:data) { { 'id' => player.id, 'position' => 30 } }
  let(:repository) { PlayerRoomRepository.new }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end
  let(:update_player_room_record) do
    described_class.new(repository: repository)
  end

  context 'when the player and room exist' do
    subject { update_player_room_record.call(data: data, room_id: room.id) }

    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    it 'succeeds' do
      expect(subject.successful?).to be(true)
    end

    it 'updates the player position specified in the data and room' do
      expect(subject.updated_player_room_record.player_id).to eq(player.id)
      expect(subject.updated_player_room_record.room_id).to eq(room.id)
      expect(subject.updated_player_room_record.position).to eq(30)
    end
  end
end
