module Api
  module Views
    module Rooms
      class Show
        include Api::View

        def render
          raw JSON.generate({ id: room.id })
        end
      end
    end
  end
end
