require 'spec_helper'

RSpec.describe Websocket::Interactor::HandleMessage do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:clients) { [client_1, client_2] }

  describe '#call' do
    describe 'a position update' do
      let(:data) { { 'position' => 5 } }
      subject do
        described_class.new.call(data: data, client: client_1, clients: clients)
      end

      before do
        allow(client_1.player).to receive(:id)
        allow(client_2.player).to receive(:id)
      end

      it 'updates the clients position' do
        subject
        expect(client_1.position).to eq(5)
      end

      it('updates all clients with the race status') do
        expect(client_1.connection).to receive(:write)
        expect(client_2.connection).to receive(:write)
        subject
      end
    end

    describe 'the countdown has started' do
      let(:data) { { 'countdown' => true } }
      subject do
        described_class.new.call(data: data, client: client_1, clients: clients)
      end

      before do
        allow(client_1.player).to receive(:id)
        allow(client_2.player).to receive(:id)
      end

      it 'updates all clients with the timer status' do
        expect(client_1.connection).to receive(:write).with(
          '{"countdown":true}'
        )
        expect(client_2.connection).to receive(:write).with(
          '{"countdown":true}'
        )
        subject
      end
    end
  end
end
