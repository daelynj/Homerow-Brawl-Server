require './lib/middleware/websocket/interactors/models/states/countdown_state'

module Websocket
  module Interactor
    class CountdownUpdate
      def call(connection:, room_id:)
        connection.publish "#{room_id}",
                           "#{
                             Model::CountdownState.new(countdown_state: true)
                               .to_json
                           }"
      end
    end
  end
end
