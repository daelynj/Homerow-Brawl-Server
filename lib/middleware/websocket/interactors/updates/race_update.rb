require './lib/middleware/websocket/interactors/models/states/race_state'
require './lib/typinggame_server/interactors/players_rooms/fetch_players_names_positions'

module Websocket
  module Interactor
    class RaceUpdate
      def call(connection:, room_id:)
        players = build_players(room_id: room_id)

        connection.publish "#{room_id}",
                           "#{Model::RaceState.new(players: players).to_json}"
      end

      private

      def build_players(room_id:)
        players_names_positions =
          fetch_players_names_positions(room_id: room_id)

        players =
          players_names_positions.map do |player|
            {
              'id' => player[:player_id],
              'name' => player[:name],
              'position' => player[:position]
            }
          end
      end

      def fetch_players_names_positions(room_id:)
        Interactors::PlayersRooms::FetchPlayersNamesPositions.new.call(
          room_id: room_id
        )
          .players_names_positions
      end
    end
  end
end
