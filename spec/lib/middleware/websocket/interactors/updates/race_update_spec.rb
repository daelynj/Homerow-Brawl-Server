require 'spec_helper'

RSpec.describe Websocket::Interactor::RaceUpdate do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:clients) { [client_1, client_2] }

  describe '#race_update' do
    subject { described_class.new.call(clients: clients) }

    before do
      allow(client_1.player).to receive(:id).and_return(1)
      allow(client_2.player).to receive(:id).and_return(2)
    end

    it 'calls the write method for each client' do
      expect(client_1.connection).to receive(:write)
      expect(client_2.connection).to receive(:write)
      subject
    end
  end
end
