require './lib/middleware/websocket/interactors/updates/countdown_update'
require './lib/typinggame_server/interactors/rooms/update_room'

module Websocket
  module Interactor
    module Handler
      class HandleCountdownUpdate
        def call(connection:, room_id:)
          start_game(room_id: room_id, game_started: true)
          CountdownUpdate.new.call(connection: connection, room_id: room_id)
        end

        private

        def start_game(room_id:, game_started:)
          Interactors::Rooms::UpdateRoom.new.call(
            room_id: room_id, game_started: game_started
          )
        end
      end
    end
  end
end
