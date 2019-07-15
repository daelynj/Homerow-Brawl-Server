require './lib/middleware/websocket/interactors/payloads/race_payload'

module Websocket
  module Interactor
    class RaceUpdate
      def call(clients:)
        payload = generate_race_payload(clients: clients)
        clients.each { |client| client.connection.write(payload) }
      end

      private

      def generate_race_payload(clients:)
        RacePayload.new.call(clients: clients)
      end
    end
  end
end
