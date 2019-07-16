require './lib/middleware/websocket/client'
require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/middleware/websocket/interactors/updates/client_creation_update'
require 'json'

module Websocket
  class Controller
    attr_reader :clients, :rooms

    def initialize
      @clients = []
      @rooms = []
    end

    def on_open(connection)
      generate_client(connection: connection)
      race_update.call(clients: @clients)
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

      race_update.call(clients: @clients)
    end

    private

    def generate_client(connection:)
      @clients << Client.new(connection: connection)
      @rooms << connection.env['PATH_INFO'][1..]
      @clients.last.generate_player

      Interactor::ClientCreationUpdate.new.call(client: @clients.last)
    end

    def find_client(connection:)
      @clients.select { |client| client.connection == connection }.first
    end

    def race_update
      @race_update ||= Interactor::RaceUpdate.new
    end
  end
end
