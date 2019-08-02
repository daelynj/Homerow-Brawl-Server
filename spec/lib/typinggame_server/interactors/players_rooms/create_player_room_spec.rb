require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::CreatePlayerRoom do
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
    described_class.new(repository: repository)
  end

  describe '#call' do
    subject do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    context 'when the player and room exist' do
      it 'succeeds' do
        expect(subject.successful?).to be(true)
      end

      it 'associates a player and a room' do
        expect(subject.player_room_record).to have_attributes(
          id: Integer, player_id: Integer, room_id: Integer, position: Integer
        )
      end
    end
  end
end
