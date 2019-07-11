require './lib/middleware/websocket/interactors/build_payload'

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
        BuildPayload.new.client_creation(client: client)
      end

      def generate_race_payload(clients:)
        BuildPayload.new.race(clients: clients)
      end
    end
  end
end
