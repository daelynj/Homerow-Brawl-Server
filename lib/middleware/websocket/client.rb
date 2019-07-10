require './lib/middleware/websocket/create_player'

module Websocket
  class Client
    attr_reader :connection, :uuid, :id
    attr_accessor :position

    def initialize(connection:)
      @connection = connection
      @position = 0
      player = CreatePlayer.new.call
      @uuid = player['uuid']
      @id = player['id']
    end

    def client_attributes
      client_attributes = { 'id' => @id, 'position' => @position }
    end
  end
end
