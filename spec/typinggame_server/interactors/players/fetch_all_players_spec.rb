require 'spec_helper'

describe Interactors::Players::FetchAllPlayers do
  let(:repository) { PlayerRepository.new }
  let(:interactor) { described_class.new(repository: repository) }

  before do
    repository.clear

    repository.create(id: '1')
    repository.create(id: '2')
  end

  context 'good input' do
    let(:result) { interactor.call }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'fetches all players' do
      expect(result.players.first.id).to be(1)
      expect(result.players.length).to be(2)
    end
  end
end
