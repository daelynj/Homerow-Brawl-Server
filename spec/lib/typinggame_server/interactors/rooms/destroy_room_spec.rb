require 'spec_helper'

RSpec.describe Interactors::Rooms::DestroyRoom do
  let(:repository) { RoomRepository.new }
  let(:destroy_room) { described_class.new(repository: repository) }

  before { repository.create(id: '1', players: 0) }

  context 'nil input' do
    let(:result) { destroy_room.call(nil) }

    it 'is unsuccessful' do
      expect(result.room).to be(nil)
    end
  end

  context 'good input' do
    let(:result) { destroy_room.call('1') }

    it 'deletes the room by ID' do
      destroy_room.call('1')
      expect(repository.find('1')).to be(nil)
    end
  end
end
