module Websocket
  module Interactor
    class BuildPayload
      def call(clients: clients)
        players = []
        clients.each { |client| players << client.client_attributes }

        { 'players' => players }.to_json
      end
    end
  end
end
