module Api
  module Views
    module Players
      class Index
        include Api::View

        def render
          raw JSON.generate(players.map { |player| { id: player.id } })
        end
      end
    end
  end
end
