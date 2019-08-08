require './lib/typinggame_server/interactors/players/fetch_player'

module Websocket
  module Interactor
    class VerifyPlayer
      def call(uuid:)
        player = Interactors::Players::FetchPlayer.new.call(uuid: uuid).player

        !player.nil?
      end
    end
  end
end
