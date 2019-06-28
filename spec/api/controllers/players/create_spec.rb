RSpec.describe Api::Controllers::Players::Create, type: :action do
  let(:repository) { PlayerRepository.new }
  let(:interactor) do
    Interactors::Players::CreatePlayer.new(repository: repository)
  end
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { Hash[] }

  context 'good input' do
    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq(200)
    end

    it 'exposes a player' do
      action.call(params)
      expect(action.player).to have_attributes(id: Integer)
    end
  end
end
