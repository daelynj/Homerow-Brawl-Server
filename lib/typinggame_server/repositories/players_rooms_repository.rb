class PlayersRoomsRepository < Hanami::Repository
  def find_players_rooms_records(player_id: nil, room_id:)
    return players_rooms.where(room_id: room_id).to_a if player_id.nil?

    players_rooms.where(player_id: player_id).where(room_id: room_id).to_a.first
  end
end
