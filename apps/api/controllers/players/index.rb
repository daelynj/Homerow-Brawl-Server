module Api
  module Controllers
    module Players
      class Index
        include Api::Action

        expose :players

        def initialize(dependencies = {})
          @interactor =
            dependencies.fetch(:interactor) do
              Interactors::Players::FetchAllPlayers.new
            end
        end

        def call(_params)
          @players = @interactor.call.players
        end
      end
    end
  end
end
