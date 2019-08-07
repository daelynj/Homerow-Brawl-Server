require 'spec_helper'

RSpec.describe Websocket::Interactor::BuildUpdateModel do
  let(:connection) { double('connection') }

  describe '#call' do
    let(:build_update_model) { described_class.new }

    context 'a position update' do
      let(:update) do
        {
          type: 'position',
          id: 1,
          uuid: '6a380919-ef98-48c5-8461-12bc5790f2e6',
          name: 'octane',
          position: 30
        }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it { is_expected.to be_a(Websocket::Interactor::Model::RaceUpdate) }
    end

    context 'a join update' do
      let(:update) do
        { type: 'join', uuid: '6a380919-ef98-48c5-8461-12bc5790f2e6' }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it { is_expected.to be_a(Websocket::Interactor::Model::JoinUpdate) }
    end

    context 'a countdown update' do
      let(:update) do
        {
          type: 'countdown',
          uuid: '6a380919-ef98-48c5-8461-12bc5790f2e6',
          countdown: true
        }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it { is_expected.to be_a(Websocket::Interactor::Model::CountdownUpdate) }
    end
  end
end
