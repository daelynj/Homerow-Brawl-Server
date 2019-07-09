require './lib/middleware/websocket/client'

module Websocket
  class Controller
    attr_reader :clients

    def initialize
      @clients = []
    end

    def on_open(incoming_client)
      @clients << Client.new(connection_client: incoming_client)
    end

    def on_message(incoming_client, data)
      puts data
    end

    def on_shutdown(incoming_client)
      puts 'socket closing from the server'
    end

    def on_close(incoming_client)
      closing_client =
        @clients.select { |client| client.connection_client == incoming_client }
      @clients -= closing_client
    end
  end
end
