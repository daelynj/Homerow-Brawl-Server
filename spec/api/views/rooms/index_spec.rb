require 'spec_helper'

RSpec.describe Api::Views::Rooms::Index, type: :view do
  let(:exposures) { Hash[rooms: []] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  context 'when there are no rooms' do
    it 'renders an empty list' do
      expect(rendered).to eq('[]')
    end
  end

  context 'when there are rooms' do
    let(:rooms) { [Room.new(id: '1'), Room.new(id: '2')] }
    let(:exposures) { Hash[rooms: rooms] }

    it 'lists them all' do
      expect(rendered).to include('1')
      expect(rendered).to include('2')
    end

    it 'lists them as json' do
      expect(rendered).to eq([{ "id": 1 }, { "id": 2 }].to_json)
    end
  end
end
