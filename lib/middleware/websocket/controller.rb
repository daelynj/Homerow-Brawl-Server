require './lib/middleware/websocket/interactors/client_interactor'

module Websocket
  class Controller
    attr_reader :client_interactor

    def initialize
      @client_interactor = Interactor::ClientInteractor.new
    end

    def on_open(connection)
      @client_interactor.create_client(incoming_connection: connection)

      @client_interactor.update_all_clients
    end

    def on_message(connection, data)
      #update the Client in question
      #update_all_clients
    end

    def on_shutdown(connection)
      puts 'socket closing from the server'
    end

    def on_close(connection)
      @client_interactor.delete_client(incoming_connection: connection)
    end
  end
end
