RSpec.describe Api::Controllers::Rooms::Create, type: :action do
  let(:repository) { RoomRepository.new }
  let(:interactor) do
    Interactors::Rooms::CreateRoom.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: interactor) }
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
