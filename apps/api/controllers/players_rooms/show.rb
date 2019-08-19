module Api
  module Controllers
    module PlayersRooms
      class Show
        include Api::Action

        expose :player_stats

        def initialize(
          interactor: Interactors::PlayersRooms::FetchPlayerGlobalStats.new
        )
          @fetch_player_global_stats = interactor
        end

        def call(_params)
          uuid = JSON.parse(request.env['HTTP_UUID'])

          @player_stats =
            @fetch_player_global_stats.call(uuid: uuid).player_stats

          halt 400 && self.status = 400 if @player_stats.nil?
        end
      end
    end
  end
end
