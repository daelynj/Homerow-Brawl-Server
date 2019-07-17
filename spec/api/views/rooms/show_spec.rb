require 'spec_helper'

RSpec.describe Api::Views::Rooms::Show, type: :view do
  let(:exposures) { Hash[room: []] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  context 'when a room has been given' do
    let(:room) { Room.new(id: '2') }
    let(:exposures) { Hash[room: room] }

    it 'lists the room' do
      expect(rendered).to include('2')
    end

    it 'lists it as json' do
      expect(rendered).to eq({ "id": 2 }.to_json)
    end
  end
end
