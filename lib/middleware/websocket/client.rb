require './lib/typinggame_server/interactors/players/create_player'

module Websocket
  class Client
    attr_reader :connection, :player
    attr_accessor :position

    def initialize(connection:)
      @connection = connection
      @position = 0
    end

    def generate_player
      @player = Interactors::Players::CreatePlayer.new.call.player
    end

    def client_attributes
      client_attributes = { 'id' => @player.id, 'position' => @position }
    end
  end
end
