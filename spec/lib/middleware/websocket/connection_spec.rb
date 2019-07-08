require 'spec_helper'

RSpec.describe Websocket::Connection do
  let(:app) { double }
  let(:websocket_connection) { described_class.new(app) }
  let(:env) { { 'rack.upgrade?' => rack_upgrade?, 'rack.upgrade' => nil } }

  describe '#call' do
    subject { websocket_connection.call(env) }

    context 'when rack.upgrade? is nil' do
      let(:rack_upgrade?) { nil }

      it 'routes past the websocket middleware' do
        expect(app).to receive(:call).with(env)
        subject
      end
    end

    context 'when rack.upgrade? contains a :websocket label' do
      let(:rack_upgrade?) { :websocket }

      it 'upgrades the connection' do
        subject
        expect(env['rack.upgrade']).to be_kind_of(Websocket::Controller)
      end

      it 'returns a 200 status' do
        expect(subject).to eq([200, {}, []])
      end
    end
  end
end
