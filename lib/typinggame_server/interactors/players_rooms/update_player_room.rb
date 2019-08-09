require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class UpdatePlayerRoom
      include Hanami::Interactor

      expose :updated_player_room_record

      def initialize(repository: PlayerRoomRepository.new)
        @player_room_repository = repository
      end

      def call(player_id:, position: nil, stats_model: nil, room_id:)
        player_room_record =
          @player_room_repository.find_player_room_records(
            player_id: player_id, room_id: room_id
          )

        if position != nil
          @updated_player_room_record =
            @player_room_repository.update(
              player_room_record.id,
              position: position
            )
        end

        if stats_model != nil
          @updated_player_room_record =
            @player_room_repository.update(
              player_room_record.id,
              words_typed: stats_model.words_typed,
              time: stats_model.time,
              mistakes: stats_model.mistakes,
              letters_typed: stats_model.letters_typed
            )
        end
      end
    end
  end
end
