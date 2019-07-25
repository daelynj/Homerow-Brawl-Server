require './lib/middleware/websocket/interactors/payloads/timer_payload'

module Websocket
  module Interactor
    class TimerUpdate
      def call(connection:, room_id:)
        connection.publish "#{room_id}", "#{TimerPayload.new.call}"
      end
    end
  end
end
