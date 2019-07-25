require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::CreatePlayersRooms do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_players_rooms_record) do
    described_class.new(repository: repository)
  end

  describe '#call' do
    subject do
      create_players_rooms_record.call(player_id: player.id, room_id: room.id)
    end

    context 'when the player and room exist' do
      it 'succeeds' do
        expect(subject.successful?).to be(true)
      end

      it 'associates a player and a room' do
        expect(subject.players_rooms_record).to have_attributes(
          id: Integer, player_id: Integer, room_id: Integer, position: Integer
        )
      end
    end
  end
end
