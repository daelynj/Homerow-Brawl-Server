require './lib/middleware/websocket/interactors/verify_player'
require './lib/middleware/websocket/interactors/handlers/handle_join_update'
require './lib/middleware/websocket/interactors/handlers/handle_position_update'
require './lib/middleware/websocket/interactors/handlers/handle_countdown_update'

module Websocket
  module Interactor
    class HandleUpdate
      def call(update_model:, connection:)
        room_id = connection.env['PATH_INFO'][1..].to_i

        return if !VerifyPlayer.new.call(uuid: update_model.uuid)

        case update_model.type
        when 'join'
          Handler::HandleJoinUpdate.new.call(
            connection: connection, uuid: update_model.uuid
          )
        when 'position'
          Handler::HandlePositionUpdate.new.call(
            connection: connection,
            player_id: update_model.id,
            position: update_model.position,
            room_id: room_id
          )
        when 'countdown'
          Handler::HandleCountdownUpdate.new.call(
            connection: connection, room_id: room_id
          )
        end
      end
    end
  end
end
