require 'spec_helper'

RSpec.describe Api::Controllers::Rooms::Destroy, type: :action do
  let(:repository) { RoomRepository.new }
  let(:destroy_room) do
    Interactors::Rooms::DestroyRoom.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: destroy_room) }

  context 'nil input' do
    let(:params) { Hash[id: nil] }

    it 'is unsuccessful' do
      response = action.call(params)
      expect(response[0]).to eq(400)
    end
  end

  context 'good input' do
    let(:params) { Hash[id: '1'] }
    before { repository.create(id: '1', players: 0) }

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq(200)
      expect(repository.find(1)).to eq(nil)
    end
  end
end
