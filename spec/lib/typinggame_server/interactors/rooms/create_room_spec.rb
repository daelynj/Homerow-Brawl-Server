require 'spec_helper'

RSpec.describe Interactors::Rooms::CreateRoom do
  let(:repository) { RoomRepository.new }
  let(:create_room) { described_class.new(repository: repository) }
  let(:result) { create_room.call }

  it 'succeeds' do
    expect(result.successful?).to be(true)
  end

  it 'creates a room' do
    expect(result.room).to have_attributes(id: Integer)
  end
end
