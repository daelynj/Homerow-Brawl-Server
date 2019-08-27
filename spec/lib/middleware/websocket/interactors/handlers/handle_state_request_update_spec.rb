require 'spec_helper'

RSpec.describe Websocket::Interactor::Handler::HandleStateRequestUpdate do
  let(:connection) { double('connection') }
  let(:player_attributes_1) { { 'id' => 1, 'name' => 'octane' } }
  let(:team_1) { { 'id' => 'X0klA3' } }
  let(:access_token_1) { 'fdgdfg908g9n9gf09fgh8' }
  let(:player_attributes_2) { { 'id' => 2, 'name' => 'dominus' } }
  let(:team_2) { { 'id' => 'Ie034K' } }
  let(:access_token_2) { 'fdasdgsfgfng9gf09fghg' }

  let(:player_1) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes_1,
      team: team_1,
      access_token: access_token_1
    )
      .player
  end
  let(:player_2) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes_2,
      team: team_2,
      access_token: access_token_2
    )
      .player
  end
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end

  describe '#call' do
    subject do
      described_class.new.call(connection: connection, room_id: room.id)
    end

    before do
      create_player_room_record.call(player_id: player_1.id, room_id: room.id)
      create_player_room_record.call(player_id: player_2.id, room_id: room.id)
    end

    it 'publishes a race payload to the specified room and updates the players position' do
      expect(connection).to receive(:publish).with(
        "#{room.id}",
        "{\"type\":\"position\",\"players\":[{\"id\":#{
          player_1.id
        },\"name\":\"octane\",\"position\":0},{\"id\":#{
          player_2.id
        },\"name\":\"dominus\",\"position\":0}]}"
      )
      subject
    end
  end
end
