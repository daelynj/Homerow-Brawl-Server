require 'spec_helper'

RSpec.describe Api::Views::Players::Index, type: :view do
  let(:players) { build_players }
  let(:exposures) { Hash[players: [players]] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  it 'exposes players' do
    expect(rendered).to eq(serialized)
  end

  private

  def build_players
    object_double(Player.new, id: '1')
  end

  def serialized
    [{ id: players.id }].to_json
  end
end
