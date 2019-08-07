require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/middleware/websocket/interactors/updates/timer_update'
require './lib/middleware/websocket/interactors/handle_new_connection'
require './lib/typinggame_server/interactors/players_rooms/update_player_room'
require './lib/typinggame_server/interactors/players/fetch_player'

module Websocket
  module Interactor
    class HandleUpdate
      def call(update_model:, connection:)
        room_id = connection.env['PATH_INFO'][1..].to_i

        return if !player_verified?(uuid: update_model.uuid)

        case update_model.type
        when 'join'
          Interactor::HandleNewConnection.new.call(
            uuid: update_model.uuid, connection: connection
          )
        when 'position'
          update_player_position(update_model: update_model, room_id: room_id)
          RaceUpdate.new.call(connection: connection, room_id: room_id)
        when 'countdown'
          TimerUpdate.new.call(connection: connection, room_id: room_id)
        end
      end

      private

      def update_player_position(update_model:, room_id:)
        Interactors::PlayersRooms::UpdatePlayerRoom.new.call(
          player_id: update_model.id,
          position: update_model.position,
          room_id: room_id
        )
      end

      def player_verified?(uuid:)
        player = Interactors::Players::FetchPlayer.new.call(uuid: uuid).player

        !player.nil?
      end
    end
  end
end
