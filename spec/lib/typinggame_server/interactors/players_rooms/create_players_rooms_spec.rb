require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::CreatePlayersRooms do
  let(:player) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayersRoomsRepository.new }
  let(:create_player_room) { described_class.new(repository: repository) }

  describe '#call' do
    subject { create_player_room.call(player_id: player.id, room_id: room.id) }

    context 'when the player and room exist' do
      it 'succeeds' do
        expect(subject.successful?).to be(true)
      end

      it 'associates a player and a room' do
        expect(subject.player_room).to have_attributes(
          id: Integer, player_id: Integer, room_id: Integer, position: Integer
        )
      end
    end
  end
end
