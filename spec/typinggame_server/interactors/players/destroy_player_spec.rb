require 'spec_helper'
require 'securerandom'

describe Interactors::Players::DestroyPlayer do
  let(:repository) { PlayerRepository.new }
  let(:interactor) { described_class.new(repository: repository) }
  let(:uuid) { SecureRandom.uuid }

  before { repository.create(id: '1', token: uuid) }

  context 'nil input' do
    let(:result) { interactor.call(nil) }

    it 'is unsuccessful' do
      expect(result.player).to be(nil)
    end
  end

  context 'bad input' do
    let(:result) { interactor.call('2bbca412-65cc-4e35-a5b3-6a0a0fd') }

    it 'is unsuccessful' do
      expect(result.player).to be(nil)
    end
  end

  context 'good input' do
    it 'deletes the player by ID' do
      interactor.call(uuid)
      expect(repository.find_by_token(token: uuid)).to be(nil)
    end
  end
end
