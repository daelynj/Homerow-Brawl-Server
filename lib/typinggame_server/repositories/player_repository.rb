class PlayerRepository < Hanami::Repository
  def find_by_uuid(uuid:)
    players.where(uuid: uuid).to_a.first
  rescue => e
    return nil
  end

  def find_by_access_token(access_token:)
    players.where(access_token: access_token).to_a.first
  rescue => e
    return nil
  end
end
