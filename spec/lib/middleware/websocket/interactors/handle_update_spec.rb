require 'spec_helper'

RSpec.describe Websocket::Interactor::HandleUpdate do
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
  let(:handle_update) { described_class.new }
  let(:create_player_room_record) do
    Interactors::PlayersRooms::CreatePlayerRoom.new
  end

  describe '#call' do
    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    context 'when the client sends a join update' do
      let(:update_model) do
        Websocket::Interactor::Model::JoinUpdate.new(uuid: player.uuid)
      end
      subject do
        handle_update.call(update_model: update_model, connection: connection)
      end

      it 'subscribes the player to a room, and performs player join and race updates' do
        expect(connection).to receive(:subscribe).with("#{room.id}")
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

    context 'when the client sends a position update with a proper UUID' do
      let(:update_model) do
        Websocket::Interactor::Model::RaceUpdate.new(
          id: player.id, uuid: player.uuid, name: 'octane', position: 30
        )
      end
      subject do
        handle_update.call(update_model: update_model, connection: connection)
      end

      it 'updates the players position' do
        allow(connection).to receive(:publish)

        subject

        player_room_record =
          Interactors::PlayersRooms::FetchPlayerRoom.new.call(
            player_id: player.id, room_id: room.id
          )
            .player_room_record

        expect(player_room_record.position).to eq(30)
      end

      it 'sends all players in the room a race update' do
        expect(connection).to receive(:publish).with(
          "#{room.id}",
          "{\"players\":[{\"id\":#{
            player.id
          },\"name\":\"octane\",\"position\":30}]}"
        )

        subject
      end
    end

    context 'when the client sends a position update with an improper UUID' do
      let(:update_model) do
        Websocket::Interactor::Model::RaceUpdate.new(
          id: player.id,
          uuid: '6a380919-ef98-48c5-8461-12bc5790f2e6',
          name: 'octane',
          position: 30
        )
      end
      subject do
        handle_update.call(update_model: update_model, connection: connection)
      end

      it 'fails to perform the update' do
        expect(subject).to be(nil)
      end
    end

    context 'when a player sends a countdown update' do
      let(:update_model) do
        Websocket::Interactor::Model::CountdownUpdate.new(
          uuid: player.uuid, countdown_state: true
        )
      end
      subject do
        handle_update.call(update_model: update_model, connection: connection)
      end

      it 'sends all players in the room a countdown update' do
        expect(connection).to receive(:publish).with(
          "#{room.id}",
          '{"countdown":true}'
        )

        subject
      end
    end
  end
end
