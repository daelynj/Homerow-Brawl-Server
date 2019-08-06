module Websocket
  module Interactor
    class PlayerJoinPayload
      def call(player_id:, player_name:)
        { 'id' => player_id, 'name' => player_name }.to_json
      end
    end
  end
end
