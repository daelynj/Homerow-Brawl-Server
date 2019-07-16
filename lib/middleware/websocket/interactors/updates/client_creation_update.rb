require './lib/middleware/websocket/interactors/payloads/client_creation_payload'

module Websocket
  module Interactor
    class ClientCreationUpdate
      def call(client:)
        payload = generate_client_creation_payload(client: client)
        client.connection.write(payload)
      end

      private

      def generate_client_creation_payload(client:)
        ClientCreationPayload.new.call(client: client)
      end
    end
  end
end
