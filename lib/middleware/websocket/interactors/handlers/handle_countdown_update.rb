require './lib/middleware/websocket/interactors/updates/countdown_update'

module Websocket
  module Interactor
    module Handler
      class HandleCountdownUpdate
        def call(connection:, room_id:)
          CountdownUpdate.new.call(connection: connection, room_id: room_id)
        end
      end
    end
  end
end
