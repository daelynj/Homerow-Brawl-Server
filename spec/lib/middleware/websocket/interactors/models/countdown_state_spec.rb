require 'spec_helper'

RSpec.describe Websocket::Interactor::Model::CountdownState do
  let(:countdown_state_payload) { described_class.new(countdown_state: true) }

  describe '.to_json' do
    subject { countdown_state_payload.to_json }

    it 'builds a json payload' do
      expect(subject).to eq('{"type":"countdown","countdown":true}')
    end
  end
end
