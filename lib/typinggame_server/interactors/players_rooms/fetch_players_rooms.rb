require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayersRooms
      include Hanami::Interactor

      expose :player_room_records

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(room_id:)
        @player_room_records =
          @players_rooms_repository.find_player_room_records(room_id: room_id)
      end
    end
  end
end
