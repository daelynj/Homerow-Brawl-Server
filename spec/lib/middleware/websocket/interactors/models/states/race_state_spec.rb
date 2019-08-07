require 'spec_helper'

RSpec.describe Websocket::Interactor::Model::RaceState do
  let(:players) do
    [
      { id: 1, name: 'octane', position: 5 },
      { id: 2, name: 'dominus', position: 20 }
    ]
  end
  let(:race_state_payload) { described_class.new(players: players) }

  describe '.to_json' do
    subject { race_state_payload.to_json }

    it 'builds a json payload' do
      expect(subject).to eq(
        '{"type":"position","players":[{"id":1,"name":"octane","position":5},{"id":2,"name":"dominus","position":20}]}'
      )
    end
  end
end
