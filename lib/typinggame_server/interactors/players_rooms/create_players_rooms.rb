require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class CreatePlayersRooms
      include Hanami::Interactor

      expose :player_room

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(player_id:, room_id:)
        @player_room =
          @players_rooms_repository.create(
            player_id: player_id, room_id: room_id
          )
      end
    end
  end
end
