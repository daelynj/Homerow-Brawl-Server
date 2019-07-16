require 'spec_helper'

RSpec.describe Api::Views::Rooms::Create, type: :view do
  let(:exposures) { Hash[player: []] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  context 'when there are rooms' do
    let(:room) { Room.new(players: 0) }
    let(:exposures) { Hash[room: room] }

    it 'lists the ID as json' do
      expect(rendered).to eq({ "id": room.id }.to_json)
    end
  end
end
