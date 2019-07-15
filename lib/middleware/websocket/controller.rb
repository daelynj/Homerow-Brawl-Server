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
      update_clients.race_update(clients: @clients)
    end

    def on_message(connection, data)
      client = find_client(connection: connection)

      Interactor::HandleMessage.new.call(
        data: JSON.parse(data), client: client, clients: @clients
      )
    end

    def on_shutdown(connection)
      puts 'socket closing from the server'
    end

    def on_close(connection)
      client = find_client(connection: connection)
      client.delete_player
      @clients -= [client]

      Interactor::UpdateClients.new.race_update(clients: @clients)
    end

    private

    def generate_client(connection:)
      @clients << Client.new(connection: connection)
      @clients.last.generate_player

      update_clients.client_creation(client: @clients.last)
    end

    def find_client(connection:)
      @clients.select { |client| client.connection == connection }.first
    end

    def update_clients
      @update_clients ||= Interactor::UpdateClients.new
    end
  end
end
