require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayersNamesStats
      include Hanami::Interactor

      expose :players_names_stats

      def initialize(repository: PlayerRoomRepository.new)
        @player_room_repository = repository
      end

      def call(room_id:)
        @players_names_stats =
          @player_room_repository.find_players_names_stats(room_id: room_id)
      end
    end
  end
end
