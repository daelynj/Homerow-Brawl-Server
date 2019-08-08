require 'spec_helper'

RSpec.describe Websocket::Interactor::VerifyPlayer do
  let(:player_attributes) { { 'id' => 1, 'name' => 'octane' } }
  let(:team) { { 'id' => 'X0klA3' } }
  let(:access_token) { 'fdgdfg908g9n9gf09fgh8' }
  let(:player) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes,
      team: team,
      access_token: access_token
    )
      .player
  end

  describe '#call' do
    context 'player is verified' do
      subject { described_class.new.call(uuid: player.uuid) }

      it { is_expected.to be(true) }
    end

    context 'player is not verified' do
      subject { described_class.new.call(uuid: 'bad-uuid') }

      it { is_expected.to be(false) }
    end
  end
end
