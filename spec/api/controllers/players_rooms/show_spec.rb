require 'spec_helper'

RSpec.describe Api::Controllers::PlayersRooms::Show, type: :action do
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
  let(:params) { Hash['HTTP_UUID' => player.uuid.to_json] }
  let(:repository) { PlayerRoomRepository.new }
  let(:fetch_player_global_stats) do
    Interactors::PlayersRooms::FetchPlayerGlobalStats.new(
      repository: repository
    )
  end
  let(:action) { described_class.new(interactor: fetch_player_global_stats) }

  context "the player doesn't exist" do
    let(:params) { Hash['HTTP_UUID' => '75c020be-6507-4aab-ac0d-6456a5f4a667'.to_json] }

    it 'is unsuccessful' do
      response = action.call(params)
      status_code = response[0]

      expect(status_code).to eq(400)
    end
  end

  context 'the player exists' do
    let(:params) { Hash['HTTP_UUID' => player.uuid.to_json] }

    before do
      repository.create(
        player_id: player.id,
        room_id: room.id,
        words_typed: 5,
        time: 6,
        mistakes: 2,
        letters_typed: 15,
        position: 100
      )
    end

    it 'is successful' do
      response = action.call(params)
      status_code = response[0]

      expect(status_code).to eq(200)
    end

    it 'exposes a players stats' do
      action.call(params)

      expect(action.player_stats).to eq(
        fetch_player_global_stats.call(uuid: player.uuid.to_json).player_stats
      )
    end
  end
end
