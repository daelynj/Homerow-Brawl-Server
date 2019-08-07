module Websocket
  module Interactor
    module Model
      class RaceUpdate
        attr_reader :type, :id, :uuid, :name, :position

        def initialize(id:, uuid:, name:, position:)
          @type = 'position'
          @id = id
          @uuid = uuid
          @name = name
          @position = position
        end
      end
    end
  end
end
