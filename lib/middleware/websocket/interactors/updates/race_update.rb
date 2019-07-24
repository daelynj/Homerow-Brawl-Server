require './lib/middleware/websocket/interactors/payloads/race_payload'

module Websocket
  module Interactor
    class RaceUpdate
      def call(connection:, room_id:)
        connection.publish "#{room_id}",
                           "#{RacePayload.new.call(room_id: room_id)}"
      end
    end
  end
end
