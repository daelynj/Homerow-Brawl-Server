require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayersRooms do
  let(:player_1) { Interactors::Players::CreatePlayer.new.call.player }
  let(:player_2) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_players_rooms) do
    Interactors::PlayersRooms::CreatePlayersRooms.new
  end
  let(:fetch_players_rooms) { described_class.new(repository: repository) }

  before do
    create_players_rooms.call(player_id: player_1.id, room_id: room.id)
    create_players_rooms.call(player_id: player_2.id, room_id: room.id)
  end

  context 'when the player room association exists' do
    subject { fetch_players_rooms.call(room_id: room.id) }

    it 'succeeds' do
      expect(subject.successful?).to be(true)
    end

    it 'fetches all players in the specified room' do
      expect(subject.room_information.length).to eq(2)

      expect(subject.room_information[0].player_id).to eq(player_1.id)
      expect(subject.room_information[0].room_id).to eq(room.id)

      expect(subject.room_information[1].player_id).to eq(player_2.id)
      expect(subject.room_information[1].room_id).to eq(room.id)
    end
  end
end
