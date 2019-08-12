module Websocket
  module Interactor
    module Model
      class RoomState
        attr_reader :type, :game_started

        def initialize(game_started:)
          @type = 'game_started'
          @game_started = game_started
        end

        def to_json
          { type: @type, game_started: @game_started }.to_json
        end
      end
    end
  end
end
