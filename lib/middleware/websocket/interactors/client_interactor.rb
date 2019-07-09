require './lib/middleware/websocket/client'
require './lib/middleware/websocket/interactors/update_all_clients'

module Websocket
  module Interactor
    class ClientInteractor
      attr_reader :clients

      def initialize
        @clients = []
      end

      def create_client(incoming_client: client)
        @clients <<
          Client.new(
            connection_client: incoming_client, client_id: @clients.length + 1
          )
      end

      def delete_client(incoming_client: client)
        @clients -= find_client(incoming_client: incoming_client)
      end

      def find_client(incoming_client: client)
        @clients.select { |client| client.connection_client == incoming_client }
      end

      def update_all_clients
        UpdateAllClients.new(clients: @clients)
      end
    end
  end
end
