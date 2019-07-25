require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class CreatePlayerRoom
      include Hanami::Interactor

      expose :player_room_record

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(player_id:, room_id:)
        @player_room_record =
          @players_rooms_repository.create(
            player_id: player_id, room_id: room_id
          )
      end
    end
  end
end
