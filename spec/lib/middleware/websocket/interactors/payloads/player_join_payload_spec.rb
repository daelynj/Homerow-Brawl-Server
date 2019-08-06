require 'spec_helper'

RSpec.describe Websocket::Interactor::PlayerJoinPayload do
  describe '#call' do
    subject { described_class.new.call(player_id: 5, player_name: 'octane') }

    it 'builds a json payload' do
      expect(subject).to eq('{"id":5,"name":"octane"}')
    end
  end
end
