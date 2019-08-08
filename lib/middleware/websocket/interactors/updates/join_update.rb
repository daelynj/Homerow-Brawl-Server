require './lib/middleware/websocket/interactors/models/states/join_state'

module Websocket
  module Interactor
    class JoinUpdate
      def call(connection:, player_name:, player_id:)
        connection.write(
          Model::JoinState.new(id: player_id, name: player_name).to_json
        )
      end
    end
  end
end
