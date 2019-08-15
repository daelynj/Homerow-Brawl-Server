require 'spec_helper'

RSpec.describe PlayerRepository, type: :repository do
  let(:repository) { PlayerRepository.new }
  let(:player_attributes) { { 'id' => 1, 'name' => 'octane' } }
  let(:team) { { 'id' => 'X0klA3' } }
  let(:access_token) { 'fdgdfg908g9n9gf09fgh8' }
  let(:player) do
    repository.create(
      player_id: '1',
      name: 'octane',
      team_id: 'X0klA3',
      access_token: 'fdgdfg908g9n9gf09fgh8'
    )
  end

  describe '#find_by_access_token' do
    context 'nil input' do
      let(:result) { repository.find_by_access_token(access_token: nil) }

      it 'is unsuccessful' do
        expect(result).to be(nil)
      end
    end

    context 'bad input' do
      let(:result) do
        repository.find_by_access_token(
          access_token: '2bbca412-65cc-4e35-a5b3-6a0a0fd'
        )
      end

      it 'is unsuccessful' do
        expect(result).to be(nil)
      end
    end

    context 'good input' do
      let(:result) do
        repository.find_by_access_token(access_token: player.access_token)
      end

      it 'returns the player' do
        expect(result).to eq(player)
      end
    end
  end

  describe '#find_by_uuid' do
    context 'nil input' do
      let(:result) { repository.find_by_uuid(uuid: nil) }

      it 'is unsuccessful' do
        expect(result).to be(nil)
      end
    end

    context 'bad input' do
      let(:result) do
        repository.find_by_uuid(uuid: '6a380919-ef98-48c5-8461-12bc5790f2e6')
      end

      it 'is unsuccessful' do
        expect(result).to be(nil)
      end
    end

    context 'good input' do
      let(:result) { repository.find_by_uuid(uuid: player.uuid) }

      it 'returns the player' do
        expect(result).to eq(player)
      end
    end
  end
end
