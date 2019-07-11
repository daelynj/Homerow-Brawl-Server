require './lib/middleware/websocket/client'
require './lib/middleware/websocket/interactors/update_clients'
require 'json'

module Websocket
  class Controller
    attr_reader :clients

    def initialize
      @clients = []
    end

    def on_open(connection)
      generate_client(connection: connection)
      Interactor::UpdateClients.new.race_update(clients: @clients)
    end

    def on_message(connection, data)
      data = JSON.parse(data)
      client = find_client(connection: connection).first

      if (data['uuid'] == client.uuid)
        client.position = data['position']
        Interactor::UpdateClients.new.race_update(clients: @clients)
      end
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
      @clients.last.generate_player

      Interactor::UpdateClients.new.client_creation(client: @clients.last)
    end

    def find_client(connection:)
      @clients.select { |client| client.connection == connection }
    end
  end
end
