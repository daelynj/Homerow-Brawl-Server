require './lib/middleware/websocket/interactors/payloads/timer_payload'

module Websocket
  module Interactor
    class TimerUpdate
      def call(room:)
        clients = room.clients
        payload = generate_timer_payload(clients: clients)
        clients.each { |client| client.connection.write(payload) }
      end

      private

      def generate_timer_payload(clients:)
        TimerPayload.new.call
      end
    end
  end
end
