require 'spec_helper'

describe Interactors::Rooms::FetchRoom do
  let(:repository) { RoomRepository.new }
  let(:interactor) { described_class.new(repository: repository) }
  let(:params) { 1 }

  before do
    repository.create(id: '1')
    repository.create(id: '2')
  end

  context 'When the room exists' do
    let(:result) { interactor.call(params) }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'fetches a room by id' do
      expect(result.room.id).to eq(1)
    end
  end
end
