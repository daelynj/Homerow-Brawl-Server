module Websocket
  module Interactor
    class BuildPayload
      def race(clients:)
        players = []
        clients.each { |client| players << client.client_attributes }

        { 'players' => players }.to_json
      end

      def client_creation(client:)
        { 'token' => client.player.token, 'id' => client.player.id }.to_json
      end
    end
  end
end
