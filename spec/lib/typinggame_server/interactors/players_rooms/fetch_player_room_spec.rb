require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayerRoom do
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
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end
  let(:fetch_player_room_record) { described_class.new(repository: repository) }

  describe '#call' do
    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    context 'when the player_room association exists' do
      subject do
        fetch_player_room_record.call(player_id: player.id, room_id: room.id)
      end

      it 'succeeds' do
        expect(subject.successful?).to be(true)
      end

      it 'fetches the player_room record for the specified room and player' do
        expect(subject.player_room_record.player_id).to eq(player.id)
        expect(subject.player_room_record.room_id).to eq(room.id)
      end
    end
  end
end
