module Websocket
  module Interactor
    module Model
      class JoinUpdate
        attr_reader :type, :uuid

        def initialize(uuid:)
          @type = 'join'
          @uuid = uuid
        end
      end
    end
  end
end
