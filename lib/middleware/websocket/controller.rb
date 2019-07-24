require './lib/middleware/websocket/interactors/handle_new_connection'
require './lib/middleware/websocket/interactors/handle_message'
require 'json'

module Websocket
  class Controller
    def on_open(connection)
      Interactor::HandleNewConnection.new.call(connection: connection)
    end

    def on_message(connection, data)
      Interactor::HandleMessage.new.call(
        data: JSON.parse(data), connection: connection
      )
    end

    def on_shutdown(connection)
      puts 'socket closing from the server'
    end

    def on_close(connection)
      #find the Player and delete them
      #find the associated table entry and delete it
      #check if the room is empty - if yes, delete it
    end
  end
end
