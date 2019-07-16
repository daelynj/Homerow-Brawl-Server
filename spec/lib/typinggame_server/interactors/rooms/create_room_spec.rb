require 'spec_helper'

describe Interactors::Rooms::CreateRoom do
  let(:repository) { RoomRepository.new }
  let(:interactor) { described_class.new(repository: repository) }
  let(:result) { interactor.call }

  it 'succeeds' do
    expect(result.successful?).to be(true)
  end

  it 'creates a room' do
    expect(result.room).to have_attributes(id: Integer)
  end
end
