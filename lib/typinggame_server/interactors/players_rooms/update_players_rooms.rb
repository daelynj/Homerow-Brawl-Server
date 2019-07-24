require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class UpdatePlayersRooms
      include Hanami::Interactor

      expose :updated_player

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(data:, room_id:)
        player =
          @players_rooms_repository.find_player_in_room(
            player_id: data['id'], room_id: room_id
          )

        @updated_player =
          @players_rooms_repository.update(
            player.id,
            position: data['position']
          )
      end
    end
  end
end
