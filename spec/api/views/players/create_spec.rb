require 'spec_helper'
require 'securerandom'

RSpec.describe Api::Views::Players::Create, type: :view do
  let(:exposures) { Hash[player: []] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  context 'when there are players' do
    let(:uuid) { SecureRandom.uuid }
    let(:player) { Player.new(token: uuid) }
    let(:exposures) { Hash[player: player] }

    it 'lists the UUID as json' do
      expect(rendered).to eq({ "id": player.id, "uuid": uuid }.to_json)
    end
  end
end
