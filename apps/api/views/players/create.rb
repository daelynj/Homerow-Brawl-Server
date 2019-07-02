module Api
  module Views
    module Players
      class Create
        include Api::View

        def render
          raw JSON.generate({ uuid: player.token })
        end
      end
    end
  end
end
