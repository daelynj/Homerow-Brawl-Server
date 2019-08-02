module Api
  module Controllers
    module Slack
      class Oauth
        include Api::Action

        expose :uuid
        expose :authenticated

        def initialize(interactor: Interactors::Slack::FetchOauth.new)
          @oauth_interactor = interactor
        end

        def call(params)
          code = params[:code]
          redirect_uri = params[:redirectURI]

          halt 400 && self.status = 400 if code.nil?

          response =
            @oauth_interactor.call(code: code, redirect_uri: redirect_uri)

          @uuid = response.uuid
          @authenticated = response.authenticated
        end
      end
    end
  end
end
