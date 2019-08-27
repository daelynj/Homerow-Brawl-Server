require 'spec_helper'

RSpec.describe Websocket::Interactor::BuildUpdateModel do
  let(:connection) { double('connection') }

  describe '#call' do
    let(:build_update_model) { described_class.new }

    context 'a position update' do
      let(:update) do
        {
          'type' => 'position',
          'id' => 1,
          'uuid' => '6a380919-ef98-48c5-8461-12bc5790f2e6',
          'name' => 'octane',
          'position' => 30
        }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it { is_expected.to be_a(Websocket::Interactor::Model::RaceUpdate) }
    end

    context 'a join update' do
      let(:update) do
        { 'type' => 'join', 'uuid' => '6a380919-ef98-48c5-8461-12bc5790f2e6' }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it { is_expected.to be_a(Websocket::Interactor::Model::JoinUpdate) }
    end

    context 'a countdown update' do
      let(:update) do
        {
          'type' => 'countdown',
          'uuid' => '6a380919-ef98-48c5-8461-12bc5790f2e6',
          'countdown' => true
        }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it { is_expected.to be_a(Websocket::Interactor::Model::CountdownUpdate) }
    end

    context 'a stats update' do
      let(:update) do
        {
          'type' => 'stats',
          'uuid' => '25b26b4e-b0c2-49b0-bb06-3dc707cb7c6c',
          'id' => 1,
          'name' => 'octane',
          'words_typed' => 3,
          'time' => 1,
          'mistakes' => 0,
          'letters_typed' => 10
        }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it { is_expected.to be_a(Websocket::Interactor::Model::StatsUpdate) }
    end

    context 'a state request update' do
      let(:update) do
        {
          'type' => 'state_request',
          'uuid' => '25b26b4e-b0c2-49b0-bb06-3dc707cb7c6c'
        }
      end

      subject do
        build_update_model.call(update: update, connection: connection)
      end

      it 'is a state request update' do
        expect(subject).to be_a(
          Websocket::Interactor::Model::StateRequestUpdate
        )
      end
    end
  end
end
