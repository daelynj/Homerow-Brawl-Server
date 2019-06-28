module Api
  module Controllers
    module Players
      class Create
        include Api::Action

        expose :player

        def initialize(interactor: Interactors::Players::CreatePlayer.new)
          @interactor = interactor
        end

        def call(_params)
          @player = @interactor.call.player
        end
      end
    end
  end
end
