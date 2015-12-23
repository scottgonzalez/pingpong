class Match < ActiveRecord::Base

  @winning_player = nil
  @losing_player = nil

  has_many :games
  accepts_nested_attributes_for :games

  validates :player1_id, presence: true
  validates :player2_id, presence: true
  validate :validate_game_count
  validate :validate_winner

  def player1
    Player.find(self.player1_id)
  end

  def player2
    Player.find(self.player2_id)
  end

  def winner
    if @winning_player.nil?
      determine_winner
    end
    @winning_player
  end

  def loser
    if @losing_player.nil?
      determine_winner
    end
    @losing_player
  end

  def validate_game_count
    if (self.games.size < 2)
      errors.add(:base, "Matches must contain two or three games.")
    end
  end

  def validate_winner
    if !has_winner
      errors.add(:base, "Match does not have a winner. A player must win 2 out of 3 games.")
    end
  end

  private

  def determine_winner
    get_games_won

    if @player1_games_won == @player2_games_won
      @winning_player = nil
      @losing_player = nil
    end

    if @player1_games_won > @player2_games_won
      player1_is_winner = true
    end

    if player1_is_winner
      @winning_player = player1
      @losing_player = player2
    else
      @winning_player = player2
      @losing_player = player1
    end
  end

  def get_games_won
    @player1_games_won = 0
    @player2_games_won = 0

    self.games.select do |game|
      if game.player1_score > game.player2_score
        @player1_games_won += 1
      else
        @player2_games_won += 1
      end
    end
  end

  def has_winner
    get_games_won
    @player1_games_won != @player2_games_won
  end
end
