require 'spec_helper'

RSpec.describe Api::Controllers::Rooms::Show, type: :action do
  let(:repository) { RoomRepository.new }
  let(:interactor) { Interactors::Rooms::FetchRoom.new(repository: repository) }
  let(:action) { described_class.new(interactor: interactor) }

  context "the room doesn't exist" do
    it 'is unsuccessful' do
      response = action.call(id: 1)
      status_code = response[0]

      expect(status_code).to eq(404)
    end
  end

  context 'the room exists' do
    before do
      repository.create(id: '1')
      repository.create(id: '2')
    end

    it 'is successful' do
      response = action.call(id: 1)
      status_code = response[0]

      expect(status_code).to eq(200)
    end

    it 'exposes a room' do
      action.call(id: 1)

      expect(action.room.id).to eq(1)
    end
  end
end
