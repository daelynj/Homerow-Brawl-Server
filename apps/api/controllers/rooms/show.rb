module Api
  module Controllers
    module Rooms
      class Show
        include Api::Action

        expose :room

        def initialize(interactor: Interactors::Rooms::FetchRoom.new)
          @interactor = interactor
        end

        def call(params)
          room = @interactor.call(params[:id]).room
          halt 404 if room.nil?
          @room = room
        end
      end
    end
  end
end
