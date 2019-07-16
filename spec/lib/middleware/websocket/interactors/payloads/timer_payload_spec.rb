require 'spec_helper'

RSpec.describe Websocket::Interactor::TimerPayload do
  describe '#call' do
    subject { described_class.new.call }

    it 'builds a json payload' do
      subject
      expect(subject).to eq('{"countdown":true}')
    end
  end
end
