require './lib/middleware/websocket/interactors/build_payload'

module Websocket
  module Interactor
    class UpdateAllClients
      def call(clients: clients)
        payload = generate_payload(clients: clients)
        clients.each { |client| client.connection.write(payload) }
      end

      private

      def generate_payload(clients: clients)
        BuildPayload.new.call(clients: clients)
      end
    end
  end
end
