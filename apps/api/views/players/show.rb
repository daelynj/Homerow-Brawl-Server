module Api
  module Views
    module Players
      class Show
        include Api::View

        def render
          raw JSON.generate({ id: player.id })
        end
      end
    end
  end
end
