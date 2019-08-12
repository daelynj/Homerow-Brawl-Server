require 'hanami/interactor'

module Interactors
  module Rooms
    class UpdateRoom
      include Hanami::Interactor

      expose :updated_room

      def initialize(repository: RoomRepository.new)
        @rooms_repository = repository
      end

      def call(room_id:, game_started:)
        @updated_room =
          @rooms_repository.update(room_id, game_started: game_started)
      end
    end
  end
end
