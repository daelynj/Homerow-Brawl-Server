require './lib/middleware/websocket/interactors/build_payload'

module Websocket
  module Interactor
    class UpdateAllClients
      def initialize(clients: clients)
        @clients = clients
        @payload = generate_payload
        perform_update
      end

      def perform_update
        @clients.each { |client| client.connection_client.write(@payload) }
      end

      def generate_payload
        BuildPayload.new(clients: @clients).payload
      end
    end
  end
end
