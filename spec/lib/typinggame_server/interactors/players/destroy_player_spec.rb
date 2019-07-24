require 'spec_helper'
require 'securerandom'

RSpec.describe Interactors::Players::DestroyPlayer do
  let(:repository) { PlayerRepository.new }
  let(:destroy_player) { described_class.new(repository: repository) }
  let(:uuid) { SecureRandom.uuid }

  before { repository.create(id: '1', token: uuid) }

  context 'nil input' do
    let(:result) { destroy_player.call(nil) }

    it 'is unsuccessful' do
      expect(result.player).to be(nil)
    end
  end

  context 'bad input' do
    let(:result) { destroy_player.call('2bbca412-65cc-4e35-a5b3-6a0a0fd') }

    it 'is unsuccessful' do
      expect(result.player).to be(nil)
    end
  end

  context 'good input' do
    it 'deletes the player by ID' do
      destroy_player.call(uuid)
      expect(repository.find_by_token(token: uuid)).to be(nil)
    end
  end
end
