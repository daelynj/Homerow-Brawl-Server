require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:incoming_client_1) { double }
  let(:incoming_client_2) { double }
  let (:controller) do
    described_class.new
  end

  describe '#on_open' do
    subject { controller.on_open(incoming_client_1) }

    it 'generates a Client' do
      expect(subject.first).to be_kind_of(Websocket::Client)
    end

    it 'appends a Client to the client list' do
      subject
      client = controller.clients.first

      expect(client.connection_client).to eq(incoming_client_1)
    end

    it 'assigns an incremental ID to an incoming client' do
      subject
      controller.on_open(incoming_client_2)

      expect(controller.clients[0].client_id).to eq(1)
      expect(controller.clients[1].client_id).to eq(2)
    end
  end
end
