require 'spec_helper'

RSpec.describe Websocket::Interactor::RacePayload do
  let(:player_1) { Interactors::Players::CreatePlayer.new.call.player }
  let(:player_2) { Interactors::Players::CreatePlayer.new.call.player }
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:create_player_room) { Interactors::PlayersRooms::CreatePlayersRooms.new }
  let(:result) { described_class.new.call(room_id: room.id) }

  describe '#call' do
    before do
      create_player_room.call(player_id: player_1.id, room_id: room.id)
      create_player_room.call(player_id: player_2.id, room_id: room.id)
    end

    it 'builds a payload of all players IDs and positions in the given room' do
      expect(result).to eq(
        "{\"players\":[{\"id\":#{player_1.id},\"position\":0},{\"id\":#{
          player_2.id
        },\"position\":0}]}"
      )
    end
  end
end
