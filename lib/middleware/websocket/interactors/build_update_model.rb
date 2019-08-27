require './lib/middleware/websocket/interactors/models/updates/join_update'
require './lib/middleware/websocket/interactors/models/updates/race_update'
require './lib/middleware/websocket/interactors/models/updates/countdown_update'
require './lib/middleware/websocket/interactors/models/updates/state_request_update'

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
        when 'stats'
          Model::StatsUpdate.new(
            id: update['id'],
            uuid: update['uuid'],
            name: update['name'],
            words_typed: update['words_typed'],
            time: update['time'],
            mistakes: update['mistakes'],
            letters_typed: update['letters_typed']
          )
        when 'state_request'
          Model::StateRequestUpdate.new(uuid: update['uuid'])
        else
          raise InvalidType
        end
      end
    end
  end
end
