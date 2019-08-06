require 'hanami/interactor'
require 'faraday'

module Interactors
  module Slack
    class FetchIdentity
      include Hanami::Interactor

      expose :uuid
      expose :authenticated

      def initialize(connection:)
        @connection = connection
      end

      def call(access_token:)
        identity_response =
          @connection.get '/api/users.identity', { token: access_token }

        body = JSON.parse(identity_response.env['body'])

        create_player(body: body, access_token: access_token) if body['ok']
      end

      private

      def create_player(body:, access_token:)
        player =
          Players::CreatePlayer.new.call(
            player_attributes: body['user'],
            team: body['team'],
            access_token: access_token
          )
            .player
        @authenticated = body['ok']
        @uuid = player.uuid
      end
    end
  end
end
