module Websocket
  module Interactor
    module Model
      class JoinUpdate
        attr_reader :type, :uuid

        def initialize(uuid:)
          @type = 'join'
          @uuid = uuid
        end

        def to_json
          { type: @type, uuid: @uuid }.to_json
        end
      end
    end
  end
end
