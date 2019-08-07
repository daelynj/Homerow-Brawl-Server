require 'spec_helper'

RSpec.describe Websocket::Interactor::Model::CountdownUpdate do
  let(:countdown_update_payload) do
    described_class.new(
      uuid: '6a380919-ef98-48c5-8461-12bc5790f2e6', countdown_state: true
    )
  end

  describe '.to_json' do
    subject { countdown_update_payload.to_json }

    it 'builds a json payload' do
      expect(subject).to eq(
        '{"type":"countdown","uuid":"6a380919-ef98-48c5-8461-12bc5790f2e6","countdown":true}'
      )
    end
  end
end
