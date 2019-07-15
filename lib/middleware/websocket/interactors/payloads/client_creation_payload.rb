module Websocket
  module Interactor
    class ClientCreationPayload
      def call(client:)
        { 'id' => client.player.id }.to_json
      end
    end
  end
end
