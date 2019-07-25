require 'spec_helper'

RSpec.describe Interactors::Rooms::FetchRoom do
  let(:repository) { RoomRepository.new }
  let(:fetch_room) { described_class.new(repository: repository) }
  let(:params) { 1 }

  before do
    repository.create(id: '1')
    repository.create(id: '2')
  end

  context 'When the room exists' do
    let(:result) { fetch_room.call(params) }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'fetches a room by id' do
      expect(result.room.id).to eq(1)
    end
  end
end
