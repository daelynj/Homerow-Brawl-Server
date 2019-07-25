require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayerRoom do
  let(:player_1) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end
  let(:fetch_player_room_record) { described_class.new(repository: repository) }

  before do
    create_player_room_record.call(player_id: player_1.id, room_id: room.id)
  end

  context 'when the player_room association exists' do
    subject do
      fetch_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    it 'succeeds' do
      expect(subject.successful?).to be(true)
    end

    it 'fetches the player_room record for the specified room and player' do
      expect(subject.player_room_record.length).to eq(1)

      expect(subject.player_room_record.player_id).to eq(player_1.id)
      expect(subject.player_room_record.room_id).to eq(room.id)
    end
  end
end
