require 'hanami/interactor'

module Interactors
  module Rooms
    class CreateRoom
      include Hanami::Interactor

      expose :room

      def initialize(repository: RoomRepository.new)
        @rooms_repository = repository
      end

      def call
        @room = @rooms_repository.create(players: 0)
      end
    end
  end
end
