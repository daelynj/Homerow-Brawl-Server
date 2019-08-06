module Api
  module Views
    module Slack
      class Oauth
        include Api::View

        def render
          if authenticated
            raw JSON.generate({ authenticated: authenticated, uuid: uuid })
          else
            raw JSON.generate({ authenticated: authenticated })
          end
        end
      end
    end
  end
end
