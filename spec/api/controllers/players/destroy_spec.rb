require 'spec_helper'
require 'securerandom'

RSpec.describe Api::Controllers::Players::Destroy, type: :action do
  let(:repository) { PlayerRepository.new }
  let(:interactor) do
    Interactors::Players::DestroyPlayer.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: interactor) }
  let(:uuid) { SecureRandom.uuid }

  context 'nil input' do
    let(:params) { Hash['HTTP_UUID' => nil] }

    it 'is unsuccessful' do
      response = action.call(params)
      expect(response[0]).to eq(400)
    end
  end

  context 'improper input' do
    let(:params) { Hash['HTTP_UUID' => '2bbca412-65cc-4e35-a5b3-6a0a0fd'] }

    it 'is unsuccessful' do
      response = action.call(params)
      expect(response[0]).to eq(400)
    end
  end

  context 'good input' do
    let(:params) { Hash['HTTP_UUID' => uuid] }
    before { repository.create(id: '5', token: uuid) }

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq(200)
      expect(repository.find(5)).to eq(nil)
    end
  end
end
