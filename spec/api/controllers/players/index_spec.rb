require 'spec_helper'

RSpec.describe Api::Controllers::Players::Index, type: :action do
  let(:interactor) { instance_double(Interactors::Players::Index) }
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { Hash[] }
  let(:players) { [instance_double(Players)] }
  let(:interactor_response) { Hanami::Interactor::Result.new(players: players) }

  describe '#call' do
    it 'fetchs the players' do
      expect(interactor).to fetch_all_players
      action.call(params)
    end

    it 'is successful' do
      allow(interactor).to fetch_all_players
      response = action.call(params)
      expect(response[0]).to eq(200)
    end

    it 'exposes the retrieved players' do
      allow(interactor).to fetch_all_players
      action.call(params)

      retrieved_players = action.exposures[:players]
      expect(retrieved_players).to eq(players)
    end
  end

  private

  def fetch_all_players
    receive(:call).and_return(interactor_response)
  end
end
