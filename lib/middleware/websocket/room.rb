module Websocket
  class Room
    attr_reader :id, :clients

    def initialize(id:)
      @id = id
      @clients = []
    end

    def add_client(client:)
      @clients << client
      client.room_id = @id
    end
  end
end
