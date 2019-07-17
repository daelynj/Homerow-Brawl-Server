require 'hanami/interactor'

module Interactors
  module Rooms
    class FetchAllRooms
      include Hanami::Interactor

      expose :rooms

      def initialize(repository: RoomRepository.new)
        @rooms_repository = repository
      end

      def call
        @rooms = @rooms_repository.all
      end
    end
  end
end
