require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/typinggame_server/interactors/players_rooms/update_player_room'

module Websocket
  module Interactor
    module Handler
      class HandlePositionUpdate
        def call(connection:, player_id:, position:, room_id:)
          update_player_position(
            player_id: player_id, position: position, room_id: room_id
          )
          #RaceUpdate.new.call(connection: connection, room_id: room_id)
        end

        private

        def update_player_position(player_id:, position:, room_id:)
          Interactors::PlayersRooms::UpdatePlayerRoom.new.call(
            player_id: player_id, position: position, room_id: room_id
          )
        end
      end
    end
  end
end
