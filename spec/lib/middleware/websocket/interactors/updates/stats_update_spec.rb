require 'spec_helper'

RSpec.describe Websocket::Interactor::StatsUpdate do
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
  let(:update_model_1) do
    Websocket::Interactor::Model::StatsUpdate.new(
      id: player_1.id,
      uuid: '25b26b4e-b0c2-49b0-bb06-3dc707cb7c6c',
      name: 'octane',
      words_typed: 3,
      time: 1,
      mistakes: 0,
      letters_typed: 10
    )
  end
  let(:update_model_2) do
    Websocket::Interactor::Model::StatsUpdate.new(
      id: player_2.id,
      uuid: '25b26b4e-b0c2-49b0-bb06-5bg707xr3j4j',
      name: 'dominus',
      words_typed: 3,
      time: 3,
      mistakes: 1,
      letters_typed: 10
    )
  end

  describe '#call' do
    context 'the first player finishes' do
      subject do
        described_class.new.call(
          connection: connection, room_id: room.id, update_model: update_model_1
        )
      end

      before do
        create_player_room_record.call(player_id: player_1.id, room_id: room.id)
        create_player_room_record.call(player_id: player_2.id, room_id: room.id)
        Interactors::PlayersRooms::UpdatePlayerRoom.new.call(
          player_id: player_1.id, stats_model: update_model_1, room_id: room.id
        )
      end

      it 'publishes a stats payload to the specified room' do
        expect(connection).to receive(:publish).with(
          "#{room.id}",
          "{\"type\":\"stats\",\"players\":[{\"id\":#{
            player_1.id
          },\"name\":\"octane\",\"words_typed\":3,\"time\":1,\"mistakes\":0,\"accuracy\":100.0,\"wpm\":120}]}"
        )
        subject
      end
    end

    context 'the second player finishes' do
      subject do
        described_class.new.call(
          connection: connection, room_id: room.id, update_model: update_model_2
        )
      end

      before do
        create_player_room_record.call(player_id: player_1.id, room_id: room.id)
        create_player_room_record.call(player_id: player_2.id, room_id: room.id)
        Interactors::PlayersRooms::UpdatePlayerRoom.new.call(
          player_id: player_1.id, stats_model: update_model_1, room_id: room.id
        )
        Interactors::PlayersRooms::UpdatePlayerRoom.new.call(
          player_id: player_2.id, stats_model: update_model_2, room_id: room.id
        )
      end

      it 'publishes a stats payload to the specified room' do
        expect(connection).to receive(:publish).with(
          "#{room.id}",
          "{\"type\":\"stats\",\"players\":[{\"id\":#{
            player_1.id
          },\"name\":\"octane\",\"words_typed\":3,\"time\":1,\"mistakes\":0,\"accuracy\":100.0,\"wpm\":120},{\"id\":#{
            player_2.id
          },\"name\":\"dominus\",\"words_typed\":3,\"time\":3,\"mistakes\":1,\"accuracy\":90.0,\"wpm\":40}]}"
        )
        subject
      end
    end
  end
end
