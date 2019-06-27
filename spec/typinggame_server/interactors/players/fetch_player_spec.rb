require 'spec_helper'

describe Interactors::Players::FetchPlayer do
  let(:repository) { PlayerRepository.new }
  let(:interactor) { described_class.new(repository: repository) }
  let(:params) { 1 }

  before do
    repository.clear

    repository.create(id: '1')
    repository.create(id: '2')
  end

  context 'good input' do
    let(:result) { interactor.call(params) }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'fetches a player by id' do
      expect(result.player.id).to eq(1)
    end
  end
end
