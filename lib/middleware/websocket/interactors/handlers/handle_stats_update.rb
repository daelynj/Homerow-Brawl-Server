require './lib/middleware/websocket/interactors/updates/stats_update'
require './lib/typinggame_server/interactors/players_rooms/update_player_room'

module Websocket
  module Interactor
    module Handler
      class HandleStatsUpdate
        def call(connection:, room_id:, update_model:)
          update_player_stats(update_model: update_model, room_id: room_id)
          StatsUpdate.new.call(
            connection: connection, room_id: room_id, update_model: update_model
          )
        end

        private

        def update_player_stats(update_model:, room_id:)
          Interactors::PlayersRooms::UpdatePlayerRoom.new.call(
            player_id: update_model.id,
            stats_model: update_model,
            room_id: room_id
          )
        end
      end
    end
  end
end
