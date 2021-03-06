require 'spec_helper'

RSpec.describe Websocket::Interactor::Handler::HandlePositionUpdate do
  let(:connection) { double('connection') }
  let(:player_attributes_1) { { 'id' => 1, 'name' => 'octane' } }
  let(:team_1) { { 'id' => 'X0klA3' } }
  let(:access_token_1) { 'fdgdfg908g9n9gf09fgh8' }

  let(:player_1) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes_1,
      team: team_1,
      access_token: access_token_1
    )
      .player
  end
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end
  let(:fetch_player_room_record) do
    Interactors::PlayersRooms::FetchPlayerRoom.new
  end

  describe '#call' do
    subject do
      fetch_player_room_record.call(player_id: player_1.id, room_id: room.id)
        .player_room_record
    end

    before do
      create_player_room_record.call(player_id: player_1.id, room_id: room.id)
      described_class.new.call(
        connection: connection,
        player_id: player_1.id,
        position: 30,
        room_id: room.id
      )
    end

    it "updates the players' position" do
      expect(subject.position).to eq(30)
    end
  end
end
