require 'spec_helper'

RSpec.describe PlayerRepository, type: :repository do
  let(:repository) { PlayerRepository.new }
  let(:uuid) { SecureRandom.uuid }

  before { @player = repository.create(id: '1', token: uuid) }

  context 'nil input' do
    let(:result) { repository.find_by_token(token: nil) }

    it 'is unsuccessful' do
      expect(result).to be(nil)
    end
  end

  context 'bad input' do
    let(:result) do
      repository.find_by_token(token: '2bbca412-65cc-4e35-a5b3-6a0a0fd')
    end

    it 'is unsuccessful' do
      expect(result).to be(nil)
    end
  end

  context 'good input' do
    let(:result) { repository.find_by_token(token: uuid) }

    it 'returns the player' do
      expect(result).to eq(@player)
    end
  end
end
