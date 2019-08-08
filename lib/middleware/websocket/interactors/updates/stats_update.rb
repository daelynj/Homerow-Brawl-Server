require './lib/middleware/websocket/interactors/models/states/stats_state'
require './lib/typinggame_server/interactors/players_rooms/fetch_players_names_stats'

module Websocket
  module Interactor
    class StatsUpdate
      def call(connection:, room_id:, update_model:)
        players = build_players(room_id: room_id)
        connection.publish "#{room_id}",
                           "#{Model::StatsState.new(players: players).to_json}"
      end

      private

      def build_players(room_id:)
        players_names_stats = fetch_players_names_stats(room_id: room_id)
        players =
          players_names_stats.map do |player|
            {
              'id' => player[:player_id],
              'name' => player[:name],
              'words_typed' => player[:words_typed],
              'time' => player[:time],
              'mistakes' => player[:mistakes],
              'accuracy' =>
                calculate_accuracy(
                  letters_typed: player[:letters_typed],
                  mistakes: player[:mistakes]
                ),
              'wpm' =>
                calculate_wpm(
                  letters_typed: player[:letters_typed], time: player[:time]
                )
            }
          end
      end

      def fetch_players_names_stats(room_id:)
        Interactors::PlayersRooms::FetchPlayersNamesStats.new.call(
          room_id: room_id
        )
          .players_names_stats
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
