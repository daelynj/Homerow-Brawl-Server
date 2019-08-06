require 'hanami/interactor'
require 'securerandom'

module Interactors
  module Players
    class CreatePlayer
      include Hanami::Interactor

      expose :player

      def initialize(repository: PlayerRepository.new)
        @player_repository = repository
      end

      def call(player_attributes:, team:, access_token:)
        @player =
          @player_repository.create(
            player_id: player_attributes['id'],
            name: player_attributes['name'],
            team_id: team['id'],
            access_token: access_token
          )
      end
    end
  end
end
