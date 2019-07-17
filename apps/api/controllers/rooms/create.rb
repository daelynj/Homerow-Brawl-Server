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
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Request-Method'] = '*'
          @room = @create_room.call.room
        end
      end
    end
  end
end
