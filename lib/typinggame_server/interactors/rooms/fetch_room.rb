require 'hanami/interactor'

module Interactors
  module Rooms
    class FetchRoom
      include Hanami::Interactor

      expose :room

      def initialize(repository: RoomRepository.new)
        @rooms_repository = repository
      end

      def call(params)
        @room = @rooms_repository.find(params)
      end
    end
  end
end
