require './lib/middleware/websocket/interactors/race_payload'
require './lib/middleware/websocket/interactors/client_creation_payload'

module Websocket
  module Interactor
    class UpdateClients
      def race_update(clients:)
        payload = generate_race_payload(clients: clients)
        clients.each { |client| client.connection.write(payload) }
      end

      def client_creation(client:)
        payload = generate_client_creation_payload(client: client)
        client.connection.write(payload)
      end

      private

      def generate_client_creation_payload(client:)
        ClientCreationPayload.new.call(client: client)
      end

      def generate_race_payload(clients:)
        RacePayload.new.call(clients: clients)
      end
    end
  end
end
