require 'spec_helper'

RSpec.describe Websocket::Interactor::RoomUpdate do
  let(:connection) { double('connection') }

  describe '#call' do
    subject do
      described_class.new.call(connection: connection, game_started: true)
    end

    it 'sends the connection a game_started update' do
      expect(connection).to receive(:write).with(
        '{"type":"game_started","game_started":true}'
      )
      subject
    end
  end
end
