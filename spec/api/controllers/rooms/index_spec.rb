require 'spec_helper'

RSpec.describe Api::Controllers::Rooms::Index, type: :action do
  let(:repository) { RoomRepository.new }
  let(:fetch_all_rooms) do
    Interactors::Rooms::FetchAllRooms.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: fetch_all_rooms) }
  let(:params) { Hash[] }

  before do
    repository.create(id: '1')
    repository.create(id: '2')
  end

  context 'good input' do
    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq(200)
    end

    it 'exposes all rooms' do
      action.call(params)

      expect(action.rooms.first.id).to eq(1)
      expect(action.rooms.length).to eq(2)
    end
  end
end
