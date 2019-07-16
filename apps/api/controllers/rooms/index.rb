module Api
  module Controllers
    module Rooms
      class Index
        include Api::Action

        expose :rooms

        def initialize(interactor: Interactors::Rooms::FetchAllRooms.new)
          @interactor = interactor
        end

        def call(_params)
          @rooms = @interactor.call.rooms
        end
      end
    end
  end
end
