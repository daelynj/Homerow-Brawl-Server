module Api
  module Views
    module Rooms
      class Create
        include Api::View

        def render
          raw JSON.generate({ id: room.id })
        end
      end
    end
  end
end
