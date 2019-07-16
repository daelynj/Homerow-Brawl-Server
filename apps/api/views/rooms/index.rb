module Api
  module Views
    module Rooms
      class Index
        include Api::View

        def render
          raw JSON.generate(rooms.map { |room| { id: room.id } })
        end
      end
    end
  end
end
