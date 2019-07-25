require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayersRooms do
  let(:player_1) { Interactors::Players::CreatePlayer.new.call.player }
  let(:player_2) { Interactors::Players::CreatePlayer.new.call.player }
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
