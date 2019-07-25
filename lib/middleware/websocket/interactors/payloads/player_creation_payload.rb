module Websocket
  module Interactor
    class PlayerCreationPayload
      def call(player_id:)
        { 'id' => player_id }.to_json
      end
    end
  end
end
