RSpec.describe Api::Controllers::Players::Create, type: :action do
  let(:repository) { PlayerRepository.new }
  let(:create_player) do
    Interactors::Players::CreatePlayer.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: create_player) }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq(200)
  end

  it 'exposes a player' do
    action.call(params)
    expect(action.player).to have_attributes(id: Integer)
  end
end
