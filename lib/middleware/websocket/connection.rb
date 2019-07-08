require './lib/middleware/websocket/client'

module Websocket
  class Connection
    def initialize(app)
      @app = app
      @client = Client.new
    end

    def call(env)
      if env['rack.upgrade?'.freeze] == :websocket
        env['rack.upgrade'.freeze] = @client.controller
        return [200, {}, []]
      end

      @app.call(env)
    end
  end
end
