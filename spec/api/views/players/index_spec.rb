require 'spec_helper'

RSpec.describe Api::Views::Players::Index, type: :view do
  let(:exposures) { Hash[players: []] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  context 'when there are no players' do
    it 'renders an empty list' do
      expect(rendered).to eq('[]')
    end
  end

  context 'when there are players' do
    let(:players) { [Player.new(id: '1'), Player.new(id: '2')] }
    let(:exposures) { Hash[players: players] }

    it 'lists them all' do
      expect(rendered).to include('1')
      expect(rendered).to include('2')
    end

    it 'lists them as json' do
      expect(rendered).to eq([{ "id": 1 }, { "id": 2 }].to_json)
    end
  end
end
