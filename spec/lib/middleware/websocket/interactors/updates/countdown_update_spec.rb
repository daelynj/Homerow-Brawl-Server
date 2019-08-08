require 'spec_helper'

RSpec.describe Websocket::Interactor::CountdownUpdate do
  let(:connection) { double('connection') }

  describe '#call' do
    subject { described_class.new.call(connection: connection, room_id: 5) }

    it 'sends a countdown update to all connections of a room in a JSON payload' do
      expect(connection).to receive(:publish).with(
        '5',
        '{"type":"countdown","countdown":true}'
      )
      subject
    end
  end
end
