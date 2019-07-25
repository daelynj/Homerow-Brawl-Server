require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayerRoom
      include Hanami::Interactor

      expose :player_room_record

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(player_id:, room_id:)
        @player_room_record =
          @player_room_repository.find_players_rooms_records(
            player_id: player_id, room_id: room_id
          )
      end
    end
  end
end
