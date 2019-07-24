require './lib/middleware/websocket/interactors/payloads/player_creation_payload'

module Websocket
  module Interactor
    class PlayerCreationUpdate
      def call(connection:, player_id:)
        connection.write(PlayerCreationPayload.new.call(player_id: player_id))
      end
    end
  end
end
