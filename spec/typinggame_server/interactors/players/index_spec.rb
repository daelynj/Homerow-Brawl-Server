require 'spec_helper'

describe Interactors::Players::Index do
  let(:repository) { instance_double(PlayersRepository) }
  let(:interactor) { described_class.new(repository: repository) }

  let(:players) { [instance_double(Players)] }

  describe '#call' do
    it 'fetchs all players' do
      expect(repository).to fetch_all_players

      interactor.call
    end

    it 'exposes the retrieved players' do
      allow(repository).to fetch_all_players

      result = interactor.call
      expect(result.players).to eq(players)
    end
  end

  private

  def fetch_all_players
    receive(:all).and_return(players)
  end
end
