module Websocket
  module Interactor
    module Model
      class StatsUpdate
        attr_reader :type,
                    :id,
                    :uuid,
                    :name,
                    :words_typed,
                    :time,
                    :mistakes,
                    :letters_typed

        def initialize(
          id:, uuid:, name:, words_typed:, time:, mistakes:, letters_typed:
        )
          @type = 'stats'
          @id = id
          @uuid = uuid
          @name = name
          @words_typed = words_typed
          @time = time
          @mistakes = mistakes
          @letters_typed = letters_typed
        end
      end
    end
  end
end
