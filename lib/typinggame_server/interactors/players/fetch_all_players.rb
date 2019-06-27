require 'hanami/interactor'

module Interactors
  module Players
    class FetchAllPlayers
      include Hanami::Interactor

      expose :players

      def initialize(repository: PlayerRepository.new)
        @players_repository = repository
      end

      def call
        @players = @players_repository.all
      end
    end
  end
end
