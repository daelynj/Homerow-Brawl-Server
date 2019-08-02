require './lib/middleware/websocket/interactors/payloads/player_join_payload'

module Websocket
  module Interactor
    class PlayerJoinUpdate
      def call(connection:, player_name:, player_id:)
        connection.write(
          PlayerJoinPayload.new.call(
            player_id: player_id, player_name: player_name
          )
        )
      end
    end
  end
end
