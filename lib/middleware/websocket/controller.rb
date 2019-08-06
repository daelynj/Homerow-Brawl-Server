require './lib/middleware/websocket/interactors/handle_message'
require 'json'

module Websocket
  class Controller
    def on_open(connection)
      #do nothing, we don't know you yet
    end

    def on_message(connection, data)
      Interactor::HandleMessage.new.call(
        data: JSON.parse(data), connection: connection
      )
    end

    def on_shutdown(connection); end

    def on_close(connection)
      connection.unsubscribe("#{connection.env['PATH_INFO'][1..]}")
    end
  end
end
