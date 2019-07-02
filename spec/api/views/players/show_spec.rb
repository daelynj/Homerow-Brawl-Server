require 'spec_helper'

RSpec.describe Api::Views::Players::Show, type: :view do
  let(:exposures) { Hash[player: []] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  context 'when a player has been given' do
    let(:player) { Player.new(id: '2') }
    let(:exposures) { Hash[player: player] }

    it 'lists the player' do
      expect(rendered).to include('2')
    end

    it 'lists it as json' do
      expect(rendered).to eq({ "id": 2 }.to_json)
    end
  end
end
