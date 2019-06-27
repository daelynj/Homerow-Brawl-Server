module Api
  module Controllers
    module Players
      class Index
        include Api::Action

        expose :players

        def initialize(interactor: Interactors::Players::FetchAllPlayers.new)
          @interactor = interactor
        end

        def call(_params)
          @players = @interactor.call.players
        end
      end
    end
  end
end
