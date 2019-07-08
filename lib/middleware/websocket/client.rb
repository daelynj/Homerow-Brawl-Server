module Websocket
  class Client
    attr_reader :connection_client, :client_id

    def initialize(connection_client: client, client_id: client_id)
      @connection_client = connection_client
      @client_id = client_id
    end
  end
end
