# frozen_string_literal: true

require 'hanami/interactor'

module Interactors
  module Players
    class Index
      include Hanami::Interactor

      expose :players

      def initialize(dependencies = {})
        @players_repository =
          dependencies.fetch(:repository) { PlayerRepository.new }
      end

      def call
        @players = @players_repository.all
      end
    end
  end
end
