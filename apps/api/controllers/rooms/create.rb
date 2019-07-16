module Api
  module Controllers
    module Rooms
      class Create
        include Api::Action

        expose :room

        def initialize(interactor: Interactors::Rooms::CreateRoom.new)
          @interactor = interactor
        end

        def call(_params)
          @room = @interactor.call.room
        end
      end
    end
  end
end
