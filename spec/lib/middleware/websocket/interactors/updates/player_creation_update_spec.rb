require 'spec_helper'

RSpec.describe Websocket::Interactor::PlayerCreationUpdate do
  let(:connection) { double('connection') }

  describe '#call' do
    subject { described_class.new.call(connection: connection, player_id: 5) }

    it 'sends the connection its associated player ID in a JSON payload' do
      expect(connection).to receive(:write).with('{"id":5}')
      subject
    end
  end
end
