require './lib/middleware/websocket/interactors/handle_update'
require './lib/middleware/websocket/interactors/build_update_model'
require 'json'

module Websocket
  class Controller
    def on_open(connection)
      #do nothing, we don't know you yet
    end

    def on_message(connection, update)
      update_model =
        Interactor::BuildUpdateModel.new.call(
          update: JSON.parse(update), connection: connection
        )

      Interactor::HandleUpdate.new.call(
        update_model: update_model, connection: connection
      )
    end

    def on_shutdown(connection); end

    def on_close(connection)
      room_id = connection.env['PATH_INFO']
      room_id.delete!('/').to_i
      connection.unsubscribe("#{room_id}")
    end
  end
end
