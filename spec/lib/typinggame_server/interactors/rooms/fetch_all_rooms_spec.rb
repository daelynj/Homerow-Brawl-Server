require 'spec_helper'

describe Interactors::Rooms::FetchAllRooms do
  let(:repository) { RoomRepository.new }
  let(:fetch_all_rooms) { described_class.new(repository: repository) }

  before do
    repository.create(id: '1')
    repository.create(id: '2')
  end

  context 'good input' do
    let(:result) { fetch_all_rooms.call }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'fetches all rooms' do
      expect(result.rooms.first.id).to be(1)
      expect(result.rooms.length).to be(2)
    end
  end
end
