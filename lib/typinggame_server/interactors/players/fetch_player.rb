require 'hanami/interactor'

module Interactors
  module Players
    class FetchPlayer
      include Hanami::Interactor

      expose :player

      def initialize(repository: PlayerRepository.new)
        @player_repository = repository
      end

      def call(access_token: nil, uuid: nil)
        if uuid.nil?
          @player =
            @player_repository.find_by_access_token(access_token: access_token)
        elsif access_token.nil?
          @player = @player_repository.find_by_uuid(uuid: uuid)
        end
      end
    end
  end
end
