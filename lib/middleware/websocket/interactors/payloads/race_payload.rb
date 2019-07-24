require './lib/typinggame_server/interactors/players_rooms/fetch_players_rooms'

module Websocket
  module Interactor
    class RacePayload
      def call(room_id:)
        players_in_room =
          Interactors::PlayersRooms::FetchPlayersRooms.new.call(
            room_id: room_id
          )
            .room_information

        players = []

        players_in_room.each do |player|
          players << { 'id' => player.player_id, 'position' => player.position }
        end

        { 'players' => players }.to_json
      end
    end
  end
end
