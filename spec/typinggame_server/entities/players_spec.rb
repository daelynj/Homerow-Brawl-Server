require 'spec_helper'

RSpec.describe Players, type: :entity do
  it 'can be initialized with an ID' do
    player = Players.new(id: '1')
    expect(player.id).to eq(1)
  end
end
