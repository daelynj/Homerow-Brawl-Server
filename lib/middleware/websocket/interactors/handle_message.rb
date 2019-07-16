require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/middleware/websocket/interactors/updates/timer_update'

module Websocket
  module Interactor
    class HandleMessage
      def call(data:, client:, clients:)
        @data = data
        @client = client
        @clients = clients

        if data.key?('position')
          client.position = data['position']
          Interactor::RaceUpdate.new.call(clients: @clients)
        elsif data.key?('countdown')
          Interactor::TimerUpdate.new.call(clients: @clients)
        end
      end
    end
  end
end
