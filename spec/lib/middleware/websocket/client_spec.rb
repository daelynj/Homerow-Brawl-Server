require 'spec_helper'

RSpec.describe Websocket::Client do
  let(:client) { described_class.new }

  it 'creates a controller' do
    expect(client.controller).to be_kind_of(Websocket::Controller)
  end
end
