require 'plezi'

class WebsocketController
  # every request that routes to this controller will create a new instance
  def initialize; end
  # Http methods are available
  def index
    'Hello World!'
  end
  # RESTful methods are available
  def show
    "showing object with id: #{params['id']}..."
  end
  # called before the protocol is swithed from HTTP to WebSockets.
  #
  # this allows setting headers, cookies and other data (such as authentication)
  # prior to opening a WebSocket.
  #
  # if the method returns false, the connection will be refused and the remaining routes will be attempted.
  def pre_connect
    true
  end
  # called immediately after a WebSocket connection has been established.
  # it blocks all the connection's actions until the `on_open` initialization is finished.
  def on_open; end
  # called when new data is recieved
  #
  # data is a string that contains binary or UTF8 (message dependent) data.
  def on_message(data)
    puts "Websocket got: #{data}"
    write "echo: #{data}"
  end
  # called once, AFTER the connection was closed.
  def on_close; end
  # called once, during **server shutdown**, BEFORE the connection is closed.
  # this will only be called for connections that are open while the server is shutting down.
  def on_shutdown
    write 'Server shutting down. Goodbye.'
  end
end

Plezi.route '/ws', WebsocketController
