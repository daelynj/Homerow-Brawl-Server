module Websocket
  module Interactor
    module Model
      class JoinState
        attr_reader :type, :id, :name

        def initialize(id:, name:)
          @type = 'join'
          @id = id
          @name = name
        end

        def to_json
          { type: @type, id: @id, name: @name }.to_json
        end
      end
    end
  end
end
