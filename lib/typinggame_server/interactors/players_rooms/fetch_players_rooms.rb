require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayersRooms
      include Hanami::Interactor

      expose :player_room_records

      def initialize(repository: PlayerRoomRepository.new)
        @player_room_repository = repository
      end

      def call(room_id:)
        @player_room_records =
          @player_room_repository.find_player_room_records(room_id: room_id)
      end
    end
  end
end
