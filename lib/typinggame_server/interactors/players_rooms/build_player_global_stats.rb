require 'hanami/interactor'

module Interactors
  module PlayersRooms
    class BuildPlayerGlobalStats
      include Hanami::Interactor

      expose :player_stats

      def call(records:)
        records.reject! { |key| key.position != 100 }

        games_played =
          records.map do |record|
            {
              created_at: record.created_at,
              words_typed: record.words_typed,
              time: record.time,
              mistakes: record.mistakes,
              letters_typed: record.letters_typed
            }
          end

        stats = calculate_stats(games_played: games_played)

        @player_stats = { games_played: games_played, stats: stats }
      end

      private

      def calculate_stats(games_played:)
        wpms = []
        accuracys = []
        words_typed = []
        letters_typed = []
        mistakes = []

        games_played.each do |game|
          wpms <<
            calculate_wpm(
              letters_typed: game[:letters_typed], time: game[:time]
            )
          game[:wpm] = wpms.last

          accuracys <<
            calculate_accuracy(
              letters_typed: game[:letters_typed], mistakes: game[:mistakes]
            )
          game[:accuracy] = accuracys.last

          mistakes << game[:mistakes]
          words_typed << game[:words_typed]
          letters_typed << game[:letters_typed]
        end

        average_wpm = wpms.inject(&:+) / games_played.size
        average_accuracy = accuracys.inject(&:+) / games_played.size

        total_mistakes = mistakes.inject(&:+)
        average_mistakes = total_mistakes / games_played.size

        total_words_typed = words_typed.inject(&:+)
        average_words_typed = total_words_typed / games_played.size

        total_letters_typed = letters_typed.inject(&:+)
        average_letters_typed = total_letters_typed / games_played.size

        {
          average_wpm: average_wpm,
          average_accuracy: average_accuracy,
          total_mistakes: total_mistakes,
          average_mistakes: average_mistakes,
          total_words_typed: total_words_typed,
          average_words_typed: average_words_typed,
          total_letters_typed: total_letters_typed,
          average_letters_typed: average_letters_typed
        }
      end

      def calculate_wpm(letters_typed:, time:)
        average_word_length = 5
        (letters_typed / average_word_length / (time.to_f / 60)).round
      end

      def calculate_accuracy(letters_typed:, mistakes:)
        accuracy =
          (((letters_typed.to_f - mistakes) / letters_typed) * 100).round(1)

        accuracy < 0 ? 0 : accuracy
      end
    end
  end
end
