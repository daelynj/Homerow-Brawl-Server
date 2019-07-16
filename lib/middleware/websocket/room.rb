module Websocket
  class Room
    attr_reader :id

    def initialize(id:)
      @id = id
      @clients = []
    end

    def add_client(client:)
      @clients << client
    end
  end
end
