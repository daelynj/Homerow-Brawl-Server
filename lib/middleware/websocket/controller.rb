require './lib/middleware/websocket/client'
require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/middleware/websocket/interactors/updates/client_creation_update'
require './lib/middleware/websocket/room'
require 'json'

module Websocket
  class Controller
    attr_reader :clients
    attr_accessor :rooms

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
      client = Client.new(connection: connection)
      setup_room(client: client)
      client.generate_player
      @clients << client

      Interactor::ClientCreationUpdate.new.call(client: @clients.last)
    end

    def find_client(connection:)
      @clients.detect { |client| client.connection == connection }
    end

    def race_update
      @race_update ||= Interactor::RaceUpdate.new
    end

    def setup_room(client:)
      connection_path = client.connection.env['PATH_INFO'][1..].to_i

      room = @rooms.detect { |room| room.id == connection_path }

      if room.nil?
        new_room = Room.new(id: connection_path)
        @rooms << new_room
        new_room.add_client(client: client)
        client.room_id = new_room.id
      else
        room.add_client(client: client)
        client.room_id = room.id
      end
    end
  end
end
