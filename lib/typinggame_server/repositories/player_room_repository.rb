class PlayerRoomRepository < Hanami::Repository
  associations { has_many :players }

  def find_player_room_records(player_id: nil, room_id:)
    return player_rooms.where(room_id: room_id).to_a if player_id.nil?

    player_rooms.where(player_id: player_id).where(room_id: room_id).to_a.first
  end

  def find_players_names_positions(room_id:)
    player_rooms.read(
      "SELECT players.name, player_rooms.position, player_rooms.player_id FROM player_rooms JOIN players ON players.id = player_rooms.player_id WHERE room_id = #{
        room_id
      }"
    )
      .map
      .to_a
  end

  def find_players_names_stats(room_id:)
    player_rooms.read(
      "SELECT players.name, player_rooms.player_id, player_rooms.words_typed, player_rooms.time, player_rooms.mistakes, player_rooms.letters_typed FROM player_rooms JOIN players ON players.id = player_rooms.player_id WHERE room_id = #{
        room_id
      } AND player_rooms.words_typed IS NOT NULL"
    )
      .map
      .to_a
  end
end
