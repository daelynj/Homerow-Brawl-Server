module Websocket
  module Interactor
    class BuildPayload
      attr_reader :payload

      def initialize(clients: clients)
        @clients = clients
        @payload = perform_build
      end

      def perform_build
        players = []
        @clients.each { |client| players << client.client_attributes }

        { 'players' => players }.to_json
      end
    end
  end
end
