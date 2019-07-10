require 'httparty'

module Websocket
  class CreatePlayer
    def call
      HTTParty.post('http://localhost:3000/api/players')
    end
  end
end
