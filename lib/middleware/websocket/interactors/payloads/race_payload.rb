require './lib/typinggame_server/interactors/players_rooms/fetch_players_names_positions'

module Websocket
  module Interactor
    class RacePayload
      def call(room_id:)
        players_names_positions =
          fetch_players_names_positions(room_id: room_id)

        players = []

        players_names_positions.each do |player|
          players <<
            {
              'id' => player[:player_id],
              'name' => player[:name],
              'position' => player[:position]
            }
        end

        { 'players' => players }.to_json
      end

      private

      def fetch_players_names_positions(room_id:)
        Interactors::PlayersRooms::FetchPlayersNamesPositions.new.call(
          room_id: room_id
        )
          .players_names_positions
      end
    end
  end
end
