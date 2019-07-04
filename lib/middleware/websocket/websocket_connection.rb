require './lib/middleware/websocket/websocket_controller'

class WebsocketConnection
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['rack.upgrade?'.freeze] == :websocket
      env['rack.upgrade'.freeze] = WebsocketController.new

      return [200, {}, []]
    end

    @app.call(env)
  end
end
