require './lib/middleware/websocket/interactors/updates/race_update'

module Websocket
  module Interactor
    module Handler
      class HandleStateRequestUpdate
        def call(connection:, room_id:)
          RaceUpdate.new.call(connection: connection, room_id: room_id)
        end
      end
    end
  end
end
