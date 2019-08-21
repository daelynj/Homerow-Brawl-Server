require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class FetchPlayerGlobalStats
      include Hanami::Interactor

      expose :player_stats

      def initialize(repository: PlayerRoomRepository.new)
        @player_room_repository = repository
      end

      def call(uuid:)
        player = Players::FetchPlayer.new.call(uuid: uuid).player

        return nil if player.nil?

        records =
          @player_room_repository.find_player_room_records(player_id: player.id)

        @player_stats =
          BuildPlayerGlobalStats.new.call(records: records).player_stats
      end
    end
  end
end
