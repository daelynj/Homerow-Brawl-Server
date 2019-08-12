require 'spec_helper'

RSpec.describe Websocket::Interactor::Model::RoomState do
  let(:room_state_payload) { described_class.new(game_started: true) }

  describe '.to_json' do
    subject { room_state_payload.to_json }

    it 'builds a json payload' do
      expect(subject).to eq('{"type":"game_started","game_started":true}')
    end
  end
end
