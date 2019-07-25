class PlayerRoomRepository < Hanami::Repository
  def find_player_room_records(player_id: nil, room_id:)
    return player_rooms.where(room_id: room_id).to_a if player_id.nil?

    player_rooms.where(player_id: player_id).where(room_id: room_id).to_a.first
  end
end
