module GamesHelper
  def game_score(game)
    if !game.nil?
      "#{game.player1_score} - #{game.player2_score}"
    end
  end
end
