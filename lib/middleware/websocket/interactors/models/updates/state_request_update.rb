module Websocket
  module Interactor
    module Model
      class StateRequestUpdate
        attr_reader :type, :uuid

        def initialize(uuid:)
          @type = 'state_request'
          @uuid = uuid
        end
      end
    end
  end
end
