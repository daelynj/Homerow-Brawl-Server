module Api
  module Controllers
    module Players
      class Show
        include Api::Action

        expose :player

        def initialize(interactor: Interactors::Players::FetchPlayer.new)
          @fetch_player = interactor
        end

        def call(params)
          player = @fetch_player.call(params[:id]).player
          halt 404 if player.nil?
          @player = player
        end
      end
    end
  end
end
