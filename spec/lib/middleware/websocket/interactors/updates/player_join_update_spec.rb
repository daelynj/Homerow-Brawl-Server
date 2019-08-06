require 'spec_helper'

RSpec.describe Websocket::Interactor::PlayerJoinUpdate do
  let(:connection) { double('connection') }

  describe '#call' do
    subject do
      described_class.new.call(
        connection: connection, player_name: 'octane', player_id: 5
      )
    end

    it 'sends the connection its associated player ID in a JSON payload' do
      expect(connection).to receive(:write).with('{"id":5,"name":"octane"}')
      subject
    end
  end
end
