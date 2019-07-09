require 'spec_helper'

RSpec.describe Websocket::Controller do
  let(:client) { double }
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
    subject { controller.on_open(client) }

    it 'tells the interactor to generate a Client' do
      expect(controller.client_interactor).to receive(:create_client).with(
        incoming_client: client
      )
      subject
    end

    it 'tells the interactor to update all clients' do
      expect(controller.client_interactor).to receive(:create_client)
      subject
    end
  end

  describe '#on_close' do
    subject { controller.on_close(client) }

    it 'tells the interactor to remove the incoming client' do
      expect(controller.client_interactor).to receive(:delete_client).with(
        incoming_client: client
      )
      subject
    end
  end

  # describe '#build_payload' do
  #   subject { controller.build_payload }

  #   it 'builds the expected payload' do
  #     controller.on_open(incoming_client_1)
  #     controller.on_open(incoming_client_2)

  #     expected_JSON =
  #       '{"players":[{"id":1,"position":"0%"},{"id":2,"position":"0%"}]}'

  #     expect(subject).to eq(expected_JSON)
  #   end
  # end

  # describe '#find_client' do
  #   subject { controller.find_client(incoming_client_2) }

  #   it 'returns the requested client' do
  #     controller.on_open(incoming_client_1)
  #     controller.on_open(incoming_client_2)

  #     expect(subject.first).to eq(controller.clients[1])
  #   end
  # end

  # describe '#update_all_clients' do
  #   subject { controller.update_all_clients }
  #   #let(:obj) { double(:write) }

  #   it 'calls the write method on each client' do
  #     controller.on_open(incoming_client_1)
  #     controller.on_open(incoming_client_2)
  #     payload = controller.build_payload

  #     expect(incoming_client_1).to receive(:write).with(payload)
  #     expect(incoming_client_2).to receive(:write).with(payload)
  #     subject
  #   end
  # end
end
