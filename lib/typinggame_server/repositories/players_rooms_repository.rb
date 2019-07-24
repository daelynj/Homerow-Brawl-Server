class PlayersRoomsRepository < Hanami::Repository
  def find_players_in_room(room_id:)
    players_rooms.where(room_id: room_id).to_a
  end

  def find_player_in_room(player_id:, room_id:)
    players_rooms.where(player_id: player_id).where(room_id: room_id).to_a.first
  end
end
