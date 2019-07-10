module Websocket
  class Client
    attr_reader :connection, :client_attributes
    attr_accessor :position

    def initialize(connection:)
      @connection = connection
      @position = 0
    end

    def client_attributes
      @client_attributes = { 'position' => @position }
    end
  end
end
