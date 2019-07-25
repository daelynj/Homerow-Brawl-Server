require 'spec_helper'

RSpec.describe Websocket::Interactor::RaceUpdate do
  let(:connection) { double('connection') }
  let(:player_1) { Interactors::Players::CreatePlayer.new.call.player }
  let(:player_2) { Interactors::Players::CreatePlayer.new.call.player }
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

    it 'publishes a race payload to the specified room' do
      expect(connection).to receive(:publish).with(
        "#{room.id}",
        "{\"players\":[{\"id\":#{player_1.id},\"position\":0},{\"id\":#{
          player_2.id
        },\"position\":0}]}"
      )
      subject
    end
  end
end
