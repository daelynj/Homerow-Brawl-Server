module Api
  module Controllers
    module Players
      class Index
        include Api::Action

        expose :players

        def initialize(interactor: Interactors::Players::FetchAllPlayers.new)
          @fetch_all_players = interactor
        end

        def call(_params)
          @players = @fetch_all_players.call.players
        end
      end
    end
  end
end
