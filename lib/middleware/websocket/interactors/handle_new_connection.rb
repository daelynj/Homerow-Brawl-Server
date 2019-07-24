require './lib/middleware/websocket/interactors/updates/player_creation_update'
require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/typinggame_server/interactors/players/create_player'
require './lib/typinggame_server/interactors/rooms/fetch_room'
require './lib/typinggame_server/interactors/players_rooms/create_players_rooms'

module Websocket
  module Interactor
    class HandleNewConnection
      def call(connection:)
        player = create_player
        room = find_room(id: connection.env['PATH_INFO'][1..].to_i)
        connection.subscribe "#{room.id}"

        build_association(player_id: player.id, room_id: room.id)

        perform_updates(
          connection: connection, player_id: player.id, room_id: room.id
        )
      end

      private

      def create_player
        Interactors::Players::CreatePlayer.new.call.player
      end

      def find_room(id:)
        Interactors::Rooms::FetchRoom.new.call(id).room
      end

      def build_association(player_id:, room_id:)
        Interactors::PlayersRooms::CreatePlayersRooms.new.call(
          player_id: player_id, room_id: room_id
        )
      end

      def perform_updates(connection:, player_id:, room_id:)
        PlayerCreationUpdate.new.call(
          connection: connection, player_id: player_id
        )

        RaceUpdate.new.call(connection: connection, room_id: room_id)
      end
    end
  end
end
