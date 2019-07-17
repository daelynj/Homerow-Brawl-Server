RSpec.describe Api::Controllers::Rooms::Create, type: :action do
  let(:repository) { RoomRepository.new }
  let(:create_room) do
    Interactors::Rooms::CreateRoom.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: create_room) }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq(200)
  end

  it 'exposes a room' do
    action.call(params)
    expect(action.room).to have_attributes(id: Integer)
  end
end
