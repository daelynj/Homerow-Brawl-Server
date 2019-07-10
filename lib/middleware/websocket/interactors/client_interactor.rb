require './lib/middleware/websocket/client'
require './lib/middleware/websocket/interactors/update_all_clients'

module Websocket
  module Interactor
    class ClientInteractor
      attr_reader :clients

      def initialize
        @clients = []
      end

      def create_client(incoming_connection:)
        @clients << Client.new(connection: incoming_connection)
      end

      def delete_client(incoming_connection:)
        @clients -= find_client(incoming_connection: incoming_connection)
      end

      def update_all_clients
        UpdateAllClients.new.call(clients: @clients)
      end

      private

      def find_client(incoming_connection:)
        @clients.select { |client| client.connection == incoming_connection }
      end
    end
  end
end
