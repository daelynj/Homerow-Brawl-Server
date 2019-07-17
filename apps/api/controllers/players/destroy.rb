module Api
  module Controllers
    module Players
      class Destroy
        include Api::Action

        def initialize(interactor: Interactors::Players::DestroyPlayer.new)
          @destroy_player = interactor
        end

        def call(_params)
          uuid = request.env['HTTP_UUID']

          player = @destroy_player.call(uuid).player
          halt 400 && self.status = 400 if player.nil?
        end
      end
    end
  end
end
