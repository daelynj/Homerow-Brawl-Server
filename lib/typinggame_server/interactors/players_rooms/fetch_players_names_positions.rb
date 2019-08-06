require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayersNamesPositions
      include Hanami::Interactor

      expose :players_names_positions

      def initialize(repository: PlayerRoomRepository.new)
        @player_room_repository = repository
      end

      def call(room_id:)
        @players_names_positions =
          @player_room_repository.find_players_names_positions(room_id: room_id)
      end
    end
  end
end
