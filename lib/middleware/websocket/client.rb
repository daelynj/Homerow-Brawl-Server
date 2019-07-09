module Websocket
  class Client
    attr_reader :connection_client

    def initialize(connection_client: client)
      @connection_client = connection_client
    end
  end
end
