require 'spec_helper'

describe Interactors::Players::CreatePlayer do
  let(:repository) { PlayerRepository.new }
  let(:interactor) { described_class.new(repository: repository) }

  context 'good input' do
    let(:result) { interactor.call }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'creates a player' do
      expect(result.player).to have_attributes(id: Integer)
    end
  end
end
