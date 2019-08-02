require 'hanami/interactor'
require 'securerandom'

module Interactors
  module Players
    class UpdatePlayer
      include Hanami::Interactor

      expose :updated_player

      def initialize(repository: PlayerRepository.new)
        @player_repository = repository
      end

      def call(player:)
        @updated_player =
          @player_repository.update(player.id, uuid: SecureRandom.uuid)
      end
    end
  end
end
