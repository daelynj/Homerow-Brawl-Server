module Api
  module Controllers
    module Rooms
      class Show
        include Api::Action

        expose :room

        def initialize(interactor: Interactors::Rooms::FetchRoom.new)
          @fetch_room = interactor
        end

        def call(params)
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Request-Method'] = '*'

          room = @fetch_room.call(params[:id]).room
          halt 404 if room.nil?
          @room = room
        end
      end
    end
  end
end
