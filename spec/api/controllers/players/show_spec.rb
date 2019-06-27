require 'spec_helper'

RSpec.describe Api::Controllers::Players::Show, type: :action do
  let(:repository) { PlayerRepository.new }
  let(:interactor) do
    Interactors::Players::FetchPlayer.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: interactor) }

  context "the player doesn't exist" do
    before { repository.clear }

    it 'is unsuccessful' do
      response = action.call(id: 1)
      expect(response[0]).to eq(400)
    end
  end

  context 'the player exists' do
    before do
      repository.clear
      repository.create(id: '1')
      repository.create(id: '2')
    end

    it 'is successful' do
      response = action.call(id: 1)

      expect(response[0]).to eq(200)
    end

    it 'exposes a player' do
      action.call(id: 1)

      expect(action.player.id).to eq(1)
    end
  end
end
