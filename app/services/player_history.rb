class PlayerHistory
  def self.from_player(player)
    Match.where("player1_id = ? OR player2_id = ?", player.id, player.id)
  end
end
