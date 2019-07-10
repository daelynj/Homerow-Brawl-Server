require './lib/middleware/websocket/client'
require './lib/middleware/websocket/interactors/update_all_clients'

module Websocket
  class Controller
    attr_reader :clients

    def initialize
      @clients = []
    end

    def on_open(connection)
      generate_client(connection: connection)

      Interactor::UpdateAllClients.new.call(clients: @clients)
    end

    def on_message(connection, data)
      #update the Client in question
      #update_all_clients
    end

    def on_shutdown(connection)
      puts 'socket closing from the server'
    end

    def on_close(connection)
      @clients -= find_client(connection: connection)
    end

    private

    def generate_client(connection:)
      @clients << Client.new(connection: connection)
      @clients[-1].generate_player
    end

    def find_client(connection:)
      @clients.select { |client| client.connection == connection }
    end
  end
end
