module Api
  module Controllers
    module Players
      class List
        include Api::Action
        accept :json

        expose :players

        def call(params)
          @players = PlayerRepository.new.all
        end
      end
    end
  end
end
