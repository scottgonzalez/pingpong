class MatchesController < ApplicationController
  def index
    @matches = Match.all.order(created_at: :desc)
  end

  def new
    @match = Match.new
    if params[:player]
      @match.player1_id = params[:player]
    end
    build_games
  end

  def edit
    @match = Match.find(params[:id])
    build_games
  end

  def create
    @match = Match.new(match_params)
    normalize_games

    if @match.save
      flash[:success] = "Match created!"
      update_stats
      redirect_to matches_path
    else
      build_games
      render 'new'
    end
  end

  def update
    @match = Match.find(params[:id])

    @previous_winner = @match.winner
    @previous_loser = @match.loser

    @match.assign_attributes(match_params)
    normalize_games

    # If the winner has changed, we need to update the players' stats
    # appropriately
    if @match.winner != @previous_winner
      update_stats_new_winner
    end

    if @match.save
      flash[:success] = "Successfully updated match!"
      redirect_to matches_path
    else
      render 'edit'
    end
  end

  def destroy
    match = Match.find(params[:id])

    # Adjust stats for this match's players
    match.winner.wins -= 1
    match.loser.losses -= 1
    match.winner.save
    match.loser.save

    if match.destroy
      flash[:success] = "Successfully deleted match!"
      redirect_to matches_path
    else
      render 'index'
    end
  end

  private

  def match_params
    params
      .require(:match)
      .permit(
        :player1_id,
        :player2_id,
        games_attributes: [:id, :player1_score, :player2_score]
      )
  end

  def build_games
    until @match.games.size == 3
      @match.games.build
    end
  end

  def normalize_games
    @match.games.each do |game|
      if !game.player1_score.present? && !game.player2_score.present?
        @match.games.delete(game)
        next
      end

      game.player1_id = @match.player1_id
      game.player2_id = @match.player2_id
    end
  end

  def update_stats
    @match.winner.wins += 1
    @match.winner.save

    @match.loser.losses += 1
    @match.loser.save
  end

  def update_stats_new_winner
    update_stats

    # The previous winner is now the loser
    @previous_winner.losses += 1
    @previous_winner.wins -= 1

    # The previous loser is now the winner
    @previous_loser.losses -= 1
    @previous_loser.wins += 1
  end
end
