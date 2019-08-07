require 'spec_helper'

RSpec.describe Websocket::Controller do
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
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end

  describe '#on_message' do
    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    context 'joining player' do
      let(:data) { { 'type' => 'join', 'uuid' => player.uuid }.to_json }

      subject { described_class.new.on_message(connection, data) }

      it 'handles the joining the player' do
        expect(connection).to receive(:subscribe).with(room.id.to_s)
        expect(connection).to receive(:write).with(
          "{\"id\":#{player.id},\"name\":\"octane\"}"
        )
        expect(connection).to receive(:publish).with(
          "#{room.id}",
          "{\"players\":[{\"id\":#{
            player.id
          },\"name\":\"octane\",\"position\":0}]}"
        )
        subject
      end
    end

    context 'race update' do
      let(:data) do
        {
          'type' => 'position',
          'uuid' => player.uuid,
          'id' => player.id,
          'position' => 30
        }.to_json
      end

      subject { described_class.new.on_message(connection, data) }

      it 'handles the message' do
        expect(connection).to receive(:publish)
        subject
      end
    end

    context 'countdown update' do
      let(:data) do
        {
          'type' => 'countdown', 'uuid' => player.uuid, 'countdown' => true
        }.to_json
      end

      subject { described_class.new.on_message(connection, data) }

      it 'handles the message' do
        expect(connection).to receive(:publish)
        subject
      end
    end
  end
end
