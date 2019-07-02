module Api
  module Controllers
    module Players
      class Show
        include Api::Action

        expose :player

        def initialize(interactor: Interactors::Players::FetchPlayer.new)
          @interactor = interactor
        end

        def call(params)
          player = @interactor.call(params[:id]).player
          halt 404 if player.nil?
          @player = player
        end
      end
    end
  end
end
