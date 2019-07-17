require 'hanami/interactor'

module Interactors
  module Rooms
    class DestroyRoom
      include Hanami::Interactor

      expose :room

      def initialize(repository: RoomRepository.new)
        @rooms_repository = repository
      end

      def call(params)
        @room = @rooms_repository.find(params)

        return nil if @room.nil?

        @rooms_repository.delete(params)
      end
    end
  end
end
