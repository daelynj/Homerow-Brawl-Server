module Websocket
  module Interactor
    module Model
      class StatsState
        attr_reader :type, :players

        def initialize(players:)
          @type = 'stats'
          @players = players
        end

        def to_json
          { type: @type, players: @players }.to_json
        end
      end
    end
  end
end
