module Websocket
  module Interactor
    class BuildPayload
      def race(clients:)
        players = []
        clients.each { |client| players << client.client_attributes }

        { 'players' => players }.to_json
      end

      def client_creation(client:)
        { 'uuid' => client.uuid, 'id' => client.id }.to_json
      end
    end
  end
end
