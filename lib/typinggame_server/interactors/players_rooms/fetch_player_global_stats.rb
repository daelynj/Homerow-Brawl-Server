require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayerGlobalStats
      include Hanami::Interactor

      expose :player_global_stats

      def initialize(repository: PlayerRoomRepository.new)
        @player_room_repository = repository
      end

      def call; end
    end
  end
end
