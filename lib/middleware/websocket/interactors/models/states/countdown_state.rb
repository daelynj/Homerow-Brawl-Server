module Websocket
  module Interactor
    module Model
      class CountdownState
        attr_reader :type, :countdown_state

        def initialize(countdown_state:)
          @type = 'countdown'
          @countdown_state = countdown_state
        end

        def to_json
          { type: @type, countdown: @countdown_state }.to_json
        end
      end
    end
  end
end
