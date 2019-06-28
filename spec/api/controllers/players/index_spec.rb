require 'spec_helper'

RSpec.describe Api::Controllers::Players::Index, type: :action do
  let(:repository) { PlayerRepository.new }
  let(:interactor) do
    Interactors::Players::FetchAllPlayers.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { Hash[] }

  before do
    repository.create(id: '1')
    repository.create(id: '2')
  end

  context 'good input' do
    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq(200)
    end

    it 'exposes all players' do
      action.call(params)

      expect(action.players.first.id).to eq(1)
      expect(action.players.length).to eq(2)
    end
  end
end
