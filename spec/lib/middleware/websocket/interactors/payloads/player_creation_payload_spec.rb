require 'spec_helper'

RSpec.describe Websocket::Interactor::PlayerCreationPayload do
  describe '#call' do
    subject { described_class.new.call(player_id: 5) }

    it 'builds a json payload' do
      expect(subject).to eq('{"id":5}')
    end
  end
end
