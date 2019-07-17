module Api
  module Controllers
    module Players
      class Create
        include Api::Action

        expose :player

        def initialize(interactor: Interactors::Players::CreatePlayer.new)
          @create_player = interactor
        end

        def call(_params)
          @player = @create_player.call.player
        end
      end
    end
  end
end
