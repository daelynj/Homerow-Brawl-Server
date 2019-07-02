require 'hanami/interactor'
require 'securerandom'

module Interactors
  module Players
    class CreatePlayer
      include Hanami::Interactor

      expose :player

      def initialize(repository: PlayerRepository.new)
        @players_repository = repository
      end

      def call
        @player = @players_repository.create(token: SecureRandom.uuid)
      end
    end
  end
end
