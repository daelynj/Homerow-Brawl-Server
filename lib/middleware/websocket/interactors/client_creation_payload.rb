module Websocket
  module Interactor
    class ClientCreationPayload
      def call(client:)
        { 'token' => client.player.token, 'id' => client.player.id }.to_json
      end
    end
  end
end
