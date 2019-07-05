require './lib/middleware/websocket/controller'

module Websocket
  class Client
    attr_reader :controller

    def initialize
      @controller = Controller.new
    end
  end
end
