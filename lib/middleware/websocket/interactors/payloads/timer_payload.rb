module Websocket
  module Interactor
    class TimerPayload
      def call
        { 'countdown' => true }.to_json
      end
    end
  end
end
