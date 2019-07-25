require './lib/typinggame_server/interactors/players_rooms/fetch_players_rooms'

module Websocket
  module Interactor
    class RacePayload
      def call(room_id:)
        player_room_records =
          Interactors::PlayersRooms::FetchPlayersRooms.new.call(
            room_id: room_id
          )
            .player_room_records

        players = []

        player_room_records.each do |player|
          players << { 'id' => player.player_id, 'position' => player.position }
        end

        { 'players' => players }.to_json
      end
    end
  end
end
