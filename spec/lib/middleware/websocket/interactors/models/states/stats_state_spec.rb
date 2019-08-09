require 'spec_helper'

RSpec.describe Websocket::Interactor::Model::StatsState do
  let(:players) do
    [
      {
        id: 1,
        name: 'octane',
        words_typed: 20,
        time: 10,
        mistakes: 2,
        accuracy: 98.0,
        wpm: 120
      },
      {
        id: 2,
        name: 'dominus',
        words_typed: 20,
        time: 14,
        mistakes: 5,
        accuracy: 95.0,
        wpm: 86
      }
    ]
  end
  let(:stats_state_payload) { described_class.new(players: players) }

  describe '.to_json' do
    subject { stats_state_payload.to_json }

    it 'builds a json payload' do
      expect(subject).to eq(
        '{"type":"stats","players":[{"id":1,"name":"octane","words_typed":20,"time":10,"mistakes":2,"accuracy":98.0,"wpm":120},{"id":2,"name":"dominus","words_typed":20,"time":14,"mistakes":5,"accuracy":95.0,"wpm":86}]}'
      )
    end
  end
end
