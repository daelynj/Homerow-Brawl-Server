require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayerRoom
      include Hanami::Interactor

      expose :player_room_record

      def initialize(repository: PlayerRoomRepository.new)
        @player_room_repository = repository
      end

      def call(player_id:, room_id:)
        @player_room_record =
          @player_room_repository.find_player_room_records(
            player_id: player_id, room_id: room_id
          )
      end
    end
  end
end
