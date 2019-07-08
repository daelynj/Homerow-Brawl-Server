require './lib/middleware/websocket/controller'

module Websocket
  class Connection
    def initialize(app)
      @app = app
      @controller = Controller.new
    end

    def call(env)
      if env['rack.upgrade?'.freeze] == :websocket
        env['rack.upgrade'.freeze] = @controller
        return [200, {}, []]
      end

      @app.call(env)
    end
  end
end
