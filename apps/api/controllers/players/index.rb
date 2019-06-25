module Api
  module Controllers
    module Players
      class Index
        include Api::Action

        expose :players

        def initialize(dependencies = {})
          @interactor =
            dependencies.fetch(:interactor) { Interactors::Players::Index.new }
        end

        def call(_params)
          result = @interactor.call
          @players = result.players
        end
      end
    end
  end
end
