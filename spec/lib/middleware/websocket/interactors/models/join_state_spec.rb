require 'spec_helper'

RSpec.describe Websocket::Interactor::Model::JoinState do
  let(:join_state_payload) { described_class.new(id: 1, name: 'octane') }

  describe '.to_json' do
    subject { join_state_payload.to_json }

    it 'builds a json payload' do
      expect(subject).to eq('{"type":"join","id":1,"name":"octane"}')
    end
  end
end
