class MatchesController < ApplicationController
  def index
    @matches = Match.all.order(created_at: :desc)
  end

  def new
    @match = Match.new
    3.times { @match.games.build }
  end

  def create
    @match = Match.new(match_params)

    @match.games.each do |game|
      if !game.player1_score.present? && !game.player2_score.present?
        @match.games.delete(game)
        next
      end

      game.player1_id = @match.player1_id
      game.player2_id = @match.player2_id
    end

    if @match.save
      flash[:success] = "Match created!"

      @match.winner.wins += 1
      @match.winner.save

      @match.loser.losses += 1
      @match.loser.save

      redirect_to matches_path
    else
      flash[:error] = "Error creating match!"
      render 'new'
    end
  end

  private

  def match_params
    params.require(:match).permit(:player1_id, :player2_id, games_attributes: [:player1_score, :player2_score])
  end
end
