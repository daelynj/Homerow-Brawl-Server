class PlayerRepository < Hanami::Repository
  def find_by_token(token:)
    players.where(token: token).to_a.first
  rescue => e
    return nil
  end
end
