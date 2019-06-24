module Api
  module Views
    module Players
      class List
        include Api::View
        layout false

        def render
          _raw JSON.dump(players.map(&:to_h))
        end
      end
    end
  end
end
