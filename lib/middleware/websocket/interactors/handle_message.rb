require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/middleware/websocket/interactors/updates/timer_update'

module Websocket
  module Interactor
    class HandleMessage
      def call(data:, room:, client:)
        @data = data
        @client = client
        @room = room

        if data.key?('position')
          client.position = data['position']
          Interactor::RaceUpdate.new.call(room: @room)
        elsif data.key?('countdown')
          Interactor::TimerUpdate.new.call(room: @room)
        end
      end
    end
  end
end
