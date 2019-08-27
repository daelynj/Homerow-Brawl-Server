require './lib/middleware/websocket/controller'

module Websocket
  class Connection
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['rack.upgrade?'.freeze] == :websocket
        env['rack.upgrade'.freeze] = Controller.new
        return [200, {}, []]
      end

      @app.call(env)
    end
  end
end
