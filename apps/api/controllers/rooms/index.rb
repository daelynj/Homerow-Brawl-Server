module Api
  module Controllers
    module Rooms
      class Index
        include Api::Action

        expose :rooms

        def initialize(interactor: Interactors::Rooms::FetchAllRooms.new)
          @fetch_all_rooms = interactor
        end

        def call(_params)
          @rooms = @fetch_all_rooms.call.rooms
        end
      end
    end
  end
end
