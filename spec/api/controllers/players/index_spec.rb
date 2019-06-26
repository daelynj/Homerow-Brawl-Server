require 'spec_helper'

RSpec.describe Api::Controllers::Players::Index, type: :action do
  let(:repository) { PlayerRepository.new }
  let(:interactor) do
    Interactors::Players::FetchAllPlayers.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { Hash[] }

  before do
    repository.clear

    repository.create(id: '1')
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq(200)
  end

  it 'exposes all players' do
    action.call(params)
    players = action.exposures[:players]

    expect(players.first.id).to eq(1)
  end
end
