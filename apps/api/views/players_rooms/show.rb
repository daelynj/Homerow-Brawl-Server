module Api
  module Views
    module PlayersRooms
      class Show
        include Api::View

        def render
          raw JSON.generate(player_stats)
        end
      end
    end
  end
end
