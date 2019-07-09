require './lib/middleware/websocket/interactors/client_interactor'

module Websocket
  class Controller
    attr_reader :client_interactor

    def initialize
      @client_interactor = Interactor::ClientInteractor.new
    end

    def on_open(client)
      @client_interactor.create_client(incoming_client: client)

      @client_interactor.update_all_clients
    end

    def on_message(client, data)
      #update the Client in question
      #update_all_clients
    end

    def on_shutdown(client)
      puts 'socket closing from the server'
    end

    def on_close(client)
      @client_interactor.delete_client(incoming_client: client)
    end
  end
end
