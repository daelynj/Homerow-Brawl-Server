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
      connection.unsubscribe("#{connection.env['PATH_INFO'][1..]}")
    end
  end
end
