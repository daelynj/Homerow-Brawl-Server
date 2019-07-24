require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayersRooms
      include Hanami::Interactor

      expose :room_information

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(room_id:)
        @room_information =
          @players_rooms_repository.find_players_in_room(room_id: room_id)
      end
    end
  end
end
