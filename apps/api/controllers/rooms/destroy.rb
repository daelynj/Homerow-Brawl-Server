module Api
  module Controllers
    module Rooms
      class Destroy
        include Api::Action

        def initialize(interactor: Interactors::Rooms::DestroyRoom.new)
          @interactor = interactor
        end

        def call(params)
          room = @interactor.call(params[:id]).room

          halt 400 && self.status = 400 if room.nil?
        end
      end
    end
  end
end
