require 'spec_helper'

RSpec.describe Interactors::Players::CreatePlayer do
  let(:player_attributes) { { 'id' => 1, 'name' => 'octane' } }
  let(:team) { { 'id' => 'X0klA3' } }
  let(:access_token) { 'fdgdfg908g9n9gf09fgh8' }
  let(:repository) { PlayerRepository.new }
  let(:create_player) { described_class.new(repository: repository) }

  describe '#call' do
    let(:result) do
      create_player.call(
        player_attributes: player_attributes,
        team: team,
        access_token: access_token
      )
    end

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'creates a player' do
      expect(result.player).to have_attributes(
        player_id: '1',
        name: 'octane',
        team_id: 'X0klA3',
        access_token: 'fdgdfg908g9n9gf09fgh8'
      )
    end
  end
end
