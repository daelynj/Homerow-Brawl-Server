module Api
  module Controllers
    module Rooms
      class Create
        include Api::Action

        expose :room

        def initialize(interactor: Interactors::Rooms::CreateRoom.new)
          @create_room = interactor
        end

        def call(_params)
          @room = @create_room.call.room
        end
      end
    end
  end
end
