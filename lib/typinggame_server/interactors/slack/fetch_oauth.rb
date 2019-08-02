require 'hanami/interactor'
require 'faraday'

module Interactors
  module Slack
    class FetchOauth
      include Hanami::Interactor

      expose :uuid
      expose :authenticated

      def initialize
        @connection =
          Faraday.new(url: 'https://slack.com') do |faraday|
            faraday.request :url_encoded
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
          end
      end

      def call(code:, redirect_uri:)
        oauth_response =
          @connection.post '/api/oauth.access',
                           {
                             client_id: ENV.fetch('CLIENT_ID'),
                             client_secret: ENV.fetch('CLIENT_SECRET'),
                             code: code,
                             redirect_uri: redirect_uri
                           }

        body = JSON.parse(oauth_response.env['body'])

        return if player_exists?(access_token: body['access_token'])

        if body['ok']
          build_player_identity(access_token: body['access_token'])
        else
          @authenticated = false
        end
      end

      private

      def player_exists?(access_token:)
        player =
          Players::FetchPlayer.new.call(access_token: access_token).player

        player.nil? ? false : update_player(player: player)
      end

      def update_player(player:)
        updated_player =
          Players::UpdatePlayer.new.call(player: player).updated_player

        @authenticated = true
        @uuid = updated_player.uuid
      end

      def build_player_identity(access_token:)
        response =
          FetchIdentity.new(connection: @connection).call(
            access_token: access_token
          )

        @uuid = response.uuid
        @authenticated = response.authenticated
      end
    end
  end
end
