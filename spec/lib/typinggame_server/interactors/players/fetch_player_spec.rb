require 'spec_helper'

RSpec.describe Interactors::Players::FetchPlayer do
  let(:repository) { PlayerRepository.new }
  let(:player) do
    repository.create(
      player_id: '1',
      name: 'octane',
      team_id: 'X0klA3',
      access_token: 'fdgdfg908g9n9gf09fgh8'
    )
  end
  let(:fetch_player) { described_class.new(repository: repository) }

  describe '#call' do
    context 'when given an access token' do
      let(:result) { fetch_player.call(access_token: 'fdgdfd408g9n9de30agh8') }

      before do
        repository.create(
          player_id: '2',
          name: 'dominus',
          team_id: 'X0MlR3',
          access_token: 'fdgdfd408g9n9de30agh8'
        )
      end

      it 'succeeds' do
        expect(result.successful?).to be(true)
      end

      it 'fetches a player by access token' do
        expect(result.player.player_id).to eq('2')
      end
    end

    context 'when given a UUID' do
      let(:result) { fetch_player.call(uuid: player.uuid) }

      it 'succeeds' do
        expect(result.successful?).to be(true)
      end

      it 'fetches a player by UUID' do
        expect(result.player.player_id).to eq('1')
      end
    end
  end
end
