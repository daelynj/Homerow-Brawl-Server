module Websocket
  class Controller
    attr_reader :clients

    def initialize
      @clients = []
    end

    def on_open(client)
      @clients << client
      puts 'Websocket connection established on the server.'
      client.write 'ack from the server'
    end

    def on_message(client, data)
      puts data
    end

    def on_shutdown(client)
      puts 'socket closing from the server'
    end

    def on_close(client)
      puts 'websocket closed from the server'
    end
  end
end
