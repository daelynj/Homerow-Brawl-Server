require './lib/typinggame_server/interactors/players/create_player'
require './lib/typinggame_server/interactors/players/destroy_player'

module Websocket
  class Client
    attr_reader :connection, :player, :room
    attr_accessor :position

    def initialize(connection:)
      @connection = connection
      @position = 0
      @room = connection.env['PATH_INFO'][1..]
    end

    def generate_player
      @player = Interactors::Players::CreatePlayer.new.call.player
    end

    def delete_player
      Interactors::Players::DestroyPlayer.new.call(@player.token)
    end

    def client_attributes
      client_attributes = { 'id' => @player.id, 'position' => @position }
    end
  end
end
