require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::UpdatePlayerRoom do
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
  let(:update_player_room_record) do
    described_class.new(repository: repository)
  end

  context 'when given a position update' do
    subject do
      update_player_room_record.call(
        player_id: player.id, position: 30, room_id: room.id
      )
    end

    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    it 'succeeds' do
      expect(subject.successful?).to be(true)
    end

    it 'updates the player position specified in the data and room' do
      expect(subject.updated_player_room_record.player_id).to eq(player.id)
      expect(subject.updated_player_room_record.room_id).to eq(room.id)
      expect(subject.updated_player_room_record.position).to eq(30)
    end
  end

  context 'when given a stats update' do
    let(:stats_model) do
      Websocket::Interactor::Model::StatsUpdate.new(
        id: 1,
        uuid: '25b26b4e-b0c2-49b0-bb06-3dc707cb7c6c',
        name: 'octane',
        words_typed: 3,
        time: 1,
        mistakes: 0,
        letters_typed: 10
      )
    end

    before do
      create_player_room_record.call(player_id: player.id, room_id: room.id)
    end

    subject do
      update_player_room_record.call(
        player_id: player.id, stats_model: stats_model, room_id: room.id
      )
    end

    it 'updates the players stats specified in the data and room' do
      expect(subject.updated_player_room_record.player_id).to eq(player.id)
      expect(subject.updated_player_room_record.room_id).to eq(room.id)
      expect(subject.updated_player_room_record.letters_typed).to eq(10)
      expect(subject.updated_player_room_record.mistakes).to eq(0)
      expect(subject.updated_player_room_record.time).to eq(1)
      expect(subject.updated_player_room_record.words_typed).to eq(3)
    end
  end
end
