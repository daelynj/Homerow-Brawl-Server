module Websocket
  module Interactor
    module Model
      class RaceState
        attr_reader :type, :players

        def initialize(players:)
          @type = 'position'
          @players = players
        end

        def to_json
          { type: @type, players: @players }.to_json
        end
      end
    end
  end
end
