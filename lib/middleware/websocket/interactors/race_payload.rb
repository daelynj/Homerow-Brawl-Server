module Websocket
  module Interactor
    class RacePayload
      def call(clients:)
        players = []
        clients.each { |client| players << client.client_attributes }

        { 'players' => players }.to_json
      end
    end
  end
end
