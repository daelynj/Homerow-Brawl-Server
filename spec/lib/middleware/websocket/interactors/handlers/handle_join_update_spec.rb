require 'spec_helper'

RSpec.describe Websocket::Interactor::Handler::HandleJoinUpdate do
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
  let(:env) { { 'PATH_INFO' => "/#{room.id}" } }
  let(:connection) { double('connection', env: env) }
  let(:handle_join_update) { described_class.new }

  describe '#call' do
    subject do
      handle_join_update.call(uuid: player.uuid, connection: connection)
    end

    it 'subscribes a new connection to a room' do
      allow(connection).to receive(:publish)
      allow(connection).to receive(:write)

      expect(connection).to receive(:subscribe).with("#{room.id}")
      subject
    end

    it 'builds an association between the player and the room' do
      allow(connection).to receive(:publish)
      allow(connection).to receive(:write)
      allow(connection).to receive(:subscribe)

      subject

      player_room_records =
        Interactors::PlayersRooms::FetchPlayersRooms.new.call(room_id: room.id)
          .player_room_records

      expect(player_room_records.length).to eq(1)
      expect(player_room_records[0].room_id).to eq(room.id)
    end

    it 'performs a player creation update' do
      allow(connection).to receive(:subscribe)
      allow(connection).to receive(:publish)

      expect(connection).to receive(:write).with(
        "{\"type\":\"join\",\"id\":#{player.id},\"name\":\"octane\"}"
      )
      subject
    end

    it 'performs a race update' do
      allow(connection).to receive(:write)
      allow(connection).to receive(:subscribe)

      expect(connection).to receive(:publish).with(
        "#{room.id}",
        "{\"type\":\"position\",\"players\":[{\"id\":#{
          player.id
        },\"name\":\"octane\",\"position\":0}]}"
      )
      subject
    end
  end
end
