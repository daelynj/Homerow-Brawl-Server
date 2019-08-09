require './lib/middleware/websocket/interactors/updates/join_update'
require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/typinggame_server/interactors/players/fetch_player'
require './lib/typinggame_server/interactors/rooms/fetch_room'
require './lib/typinggame_server/interactors/players_rooms/create_player_room'
require './lib/typinggame_server/interactors/players_rooms/fetch_player_room'

module Websocket
  module Interactor
    module Handler
      class HandleJoinUpdate
        def call(uuid:, connection:)
          room_id = connection.env['PATH_INFO']
          room_id.delete!('/').to_i

          player = fetch_player(uuid: uuid)
          room = fetch_room(id: room_id)
          connection.subscribe "#{room.id}"

          build_association(player_id: player.id, room_id: room.id)

          perform_updates(
            connection: connection,
            player_name: player.name,
            player_id: player.id,
            room_id: room.id
          )
        end

        private

        def fetch_player(uuid:)
          Interactors::Players::FetchPlayer.new.call(uuid: uuid).player
        end

        def fetch_room(id:)
          Interactors::Rooms::FetchRoom.new.call(id).room
        end

        def build_association(player_id:, room_id:)
          return if association_exists?(player_id: player_id, room_id: room_id)

          player_room_record =
            Interactors::PlayersRooms::CreatePlayerRoom.new.call(
              player_id: player_id, room_id: room_id
            )
              .player_room_record
        end

        def perform_updates(connection:, player_name:, player_id:, room_id:)
          JoinUpdate.new.call(
            connection: connection,
            player_name: player_name,
            player_id: player_id
          )

          RaceUpdate.new.call(connection: connection, room_id: room_id)
        end

        def association_exists?(player_id:, room_id:)
          player_room_record =
            Interactors::PlayersRooms::FetchPlayerRoom.new.call(
              player_id: player_id, room_id: room_id
            )
              .player_room_record

          !player_room_record.nil?
        end
      end
    end
  end
end
