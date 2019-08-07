require './lib/middleware/websocket/interactors/models/updates/join_update'
require './lib/middleware/websocket/interactors/models/updates/race_update'
require './lib/middleware/websocket/interactors/models/updates/countdown_update'

module Websocket
  module Interactor
    class BuildUpdateModel
      InvalidType = Class.new(StandardError)

      def call(update:, connection:)
        case update.fetch('type')
        when 'join'
          Model::JoinUpdate.new(uuid: update['uuid'])
        when 'position'
          Model::RaceUpdate.new(
            id: update['id'],
            uuid: update['uuid'],
            name: update['name'],
            position: update['position']
          )
        when 'countdown'
          Model::CountdownUpdate.new(
            uuid: update['uuid'], countdown_state: update['countdown']
          )
        else
          raise InvalidType
        end
      end
    end
  end
end
