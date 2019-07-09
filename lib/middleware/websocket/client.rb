module Websocket
  class Client
    attr_reader :connection_client, :client_attributes
    attr_accessor :position

    def initialize(connection_client: client)
      @connection_client = connection_client
      @position = '0%'
      @client_attributes = { 'position' => @position }
    end
  end
end
