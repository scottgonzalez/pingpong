class StatService

  def initialize(params)
    @match = params[:match]
    @winner = params[:winner]
    @loser = params[:loser]
  end

  def update_stats
    @winner.wins += 1
    @loser.losses += 1
    save_players
  end

  def update_stats_for_deleted_match
    @winner.wins -= 1
    @loser.losses -= 1
    save_players
  end

  def update_stats_for_match_with_new_winner

    # The winner of this match is now the loser
    @winner.wins -= 1
    @winner.losses += 1

    # The loser of this match is now the winner
    @loser.wins += 1
    @loser.losses -= 1

    save_players
  end

  private

  def save_players
    @winner.save
    @loser.save
  end
end
