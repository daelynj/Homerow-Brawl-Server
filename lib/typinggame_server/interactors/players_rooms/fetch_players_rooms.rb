require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayersRooms
      include Hanami::Interactor

      expose :players_rooms_records

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(room_id:)
        @players_rooms_records =
          @players_rooms_repository.find_players_rooms_records(room_id: room_id)
      end
    end
  end
end
