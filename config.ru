require './config/environment'

class WebsocketController
  def on_open(client)
    puts 'Websocket connection established on the server.'
    client.write 'ack from the server'
  end

  def on_message(client, data)
    puts data
  end

  def on_shutdown(client)
    puts 'socket closing from the server'
  end

  def on_close(client)
    puts 'websocket closed from the server'
  end
end

class Websocket
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

use Websocket
run Hanami.app
