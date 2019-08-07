module Websocket
  module Interactor
    module Model
      class CountdownUpdate
        attr_reader :type, :uuid, :countdown_state

        def initialize(uuid:, countdown_state:)
          @type = 'countdown'
          @uuid = uuid
          @countdown_state = countdown_state
        end
      end
    end
  end
end
