require 'spec_helper'

RSpec.describe Api::Views::PlayersRooms::Show, type: :view do
  let(:exposures) { Hash[player_stats: {}] }
  let(:view) { described_class.new(nil, exposures) }
  let(:rendered) { view.render }

  context 'when player_stats have been given' do
    let(:game_played) do
      {
        accuracy: 100,
        created_at: '2019-08-19 20:04:19 UTC',
        letters_typed: 10,
        mistakes: 0,
        time: 2,
        words_typed: 3,
        wpm: 60
      }
    end
    let(:stats) do
      {
        average_accuracy: 100,
        average_letters_typed: 10,
        average_mistakes: 0,
        average_words_typed: 3,
        average_wpm: 90,
        total_letters_typed: 60,
        total_mistakes: 0,
        total_words_typed: 18
      }
    end
    let(:exposures) do
      Hash[{ player_stats: { games_played: [game_played], stats: stats } }]
    end

    it 'lists the player_stats' do
      expect(rendered).to eq(exposures[:player_stats].to_json)
    end
  end
end
