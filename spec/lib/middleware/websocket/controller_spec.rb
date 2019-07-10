require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:connection) { double }
  let (:controller) do
    described_class.new
  end

  describe '#initialize' do
    it 'creates a client interactor' do
      expect(controller.client_interactor).to be_kind_of(
        Websocket::Interactor::ClientInteractor
      )
    end
  end

  describe '#on_open' do
    subject { controller.on_open(connection) }

    it 'tells the interactor to generate a Client' do
      expect(controller.client_interactor).to receive(:create_client).with(
        incoming_connection: connection
      )
      subject
    end

    it 'tells the interactor to update all clients' do
      expect(controller.client_interactor).to receive(:create_client)
      subject
    end
  end

  describe '#on_close' do
    subject { controller.on_close(connection) }

    it 'tells the interactor to remove the incoming client' do
      expect(controller.client_interactor).to receive(:delete_client).with(
        incoming_connection: connection
      )
      subject
    end
  end
end
