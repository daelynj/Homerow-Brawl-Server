require 'spec_helper'

RSpec.describe Websocket::Interactor::Model::JoinUpdate do
  let(:join_update_payload) do
    described_class.new(uuid: '6a380919-ef98-48c5-8461-12bc5790f2e6')
  end

  describe '.to_json' do
    subject { join_update_payload.to_json }

    it 'builds a json payload' do
      expect(subject).to eq(
        '{"type":"join","uuid":"6a380919-ef98-48c5-8461-12bc5790f2e6"}'
      )
    end
  end
end
