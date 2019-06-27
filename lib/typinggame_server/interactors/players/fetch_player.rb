require 'hanami/interactor'

module Interactors
  module Players
    class FetchPlayer
      include Hanami::Interactor

      expose :player

      def initialize(repository: PlayerRepository.new)
        @players_repository = repository
      end

      def call(params)
        @player = @players_repository.find(params)
      end
    end
  end
end
