require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class UpdatePlayersRooms
      include Hanami::Interactor

      expose :updated_players_rooms_record

      def initialize(repository: PlayersRoomsRepository.new)
        @players_rooms_repository = repository
      end

      def call(data:, room_id:)
        players_rooms_record =
          @players_rooms_repository.find_players_rooms_records(
            player_id: data['id'], room_id: room_id
          )

        @updated_players_rooms_record =
          @players_rooms_repository.update(
            players_rooms_record.id,
            position: data['position']
          )
      end
    end
  end
end
