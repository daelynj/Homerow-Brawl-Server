require 'hanami/interactor'

module Interactors
  module Players
    class DestroyPlayer
      include Hanami::Interactor

      expose :player

      def initialize(repository: PlayerRepository.new)
        @players_repository = repository
      end

      def call(params)
        @player = @players_repository.find_by_token(token: params)

        return nil if @player.nil?

        @players_repository.delete(@player.id)
      end
    end
  end
end
