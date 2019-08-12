require './lib/middleware/websocket/interactors/models/states/room_state'

module Websocket
  module Interactor
    class RoomUpdate
      def call(connection:, game_started:)
        connection.write(
          Model::RoomState.new(game_started: game_started).to_json
        )
      end
    end
  end
end
