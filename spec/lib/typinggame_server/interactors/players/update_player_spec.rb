require 'spec_helper'

RSpec.describe Interactors::Players::UpdatePlayer do
  let(:repository) { PlayerRepository.new }
  let(:player) do
    repository.create(
      player_id: '1',
      name: 'octane',
      team_id: 'X0klA3',
      access_token: 'fdgdfg908g9n9gf09fgh8'
    )
  end
  let(:update_player) { described_class.new(repository: repository) }

  describe '#call' do
    let(:result) { update_player.call(player: player) }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'updates a players UUID' do
      expect(result.updated_player.uuid).not_to eq(player.uuid)
    end
  end
end
