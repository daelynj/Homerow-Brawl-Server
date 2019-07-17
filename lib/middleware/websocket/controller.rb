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
      client = generate_client(connection: connection)

      race_update.call(room: find_room(id: client.room_id))
    end

    def on_message(connection, data)
      client = find_client(connection: connection)
      room = find_room(id: client.room_id)

      Interactor::HandleMessage.new.call(
        data: JSON.parse(data), room: room, client: client
      )
    end

    def on_shutdown(connection)
      puts 'socket closing from the server'
    end

    def on_close(connection)
      client = find_client(connection: connection)
      client.delete_player
      @clients -= [client]

      race_update.call(room: find_room(id: client.room_id))
    end

    private

    def generate_client(connection:)
      client = Client.new(connection: connection)
      client.generate_player
      @clients << client
      setup_room(client: client)

      Interactor::ClientCreationUpdate.new.call(client: @clients.last)

      return client
    end

    def setup_room(client:)
      connection_path = client.connection.env['PATH_INFO'][1..].to_i
      room = find_room(id: connection_path)

      if room.nil?
        room = Room.new(id: connection_path)
        @rooms << room
      end

      room.add_client(client: client)

      return room
    end

    def find_client(connection:)
      @clients.detect { |client| client.connection == connection }
    end

    def race_update
      @race_update ||= Interactor::RaceUpdate.new
    end

    def find_room(id:)
      @rooms.detect { |room| room.id == id }
    end
  end
end
