require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/middleware/websocket/interactors/updates/timer_update'
require './lib/typinggame_server/interactors/players_rooms/update_players_rooms'

module Websocket
  module Interactor
    class HandleMessage
      def call(data:, connection:)
        room_id = connection.env['PATH_INFO'][1..].to_i

        if data.key?('position')
          update_player_position(data: data, room_id: room_id)
          RaceUpdate.new.call(connection: connection, room_id: room_id)
        elsif data.key?('countdown')
          TimerUpdate.new.call(connection: connection, room_id: room_id)
        end
      end

      private

      def update_player_position(data:, room_id:)
        Interactors::PlayersRooms::UpdatePlayersRooms.new.call(
          data: data, room_id: room_id
        )
      end
    end
  end
end
