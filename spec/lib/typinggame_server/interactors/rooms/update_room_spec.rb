require 'spec_helper'

RSpec.describe Interactors::Rooms::UpdateRoom do
  let(:repository) { RoomRepository.new }
  let(:update_room) { described_class.new(repository: repository) }

  context 'starting the game' do
    let(:result) { update_room.call(room_id: 1, game_started: true) }

    before { repository.create(id: '1') }

    it 'succeeds' do
      expect(result.successful?).to be(true)
    end

    it 'updates the game_started column' do
      expect(result.updated_room.game_started).to eq(true)
    end
  end
end
