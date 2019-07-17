require 'spec_helper'

describe Interactors::Players::CreatePlayer do
  let(:repository) { PlayerRepository.new }
  let(:create_player) { described_class.new(repository: repository) }
  let(:result) { create_player.call }

  it 'succeeds' do
    expect(result.successful?).to be(true)
  end

  it 'creates a player' do
    expect(result.player).to have_attributes(id: Integer)
  end
end
