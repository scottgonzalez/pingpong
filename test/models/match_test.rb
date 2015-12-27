require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  def setup
    games = []
    2.times do
      games.push(Game.new(player1_id: 1, player2_id: 2, player1_score: 11, player2_score: 0))
    end
    @match = Match.new(player1_id: 1, player2_id: 2, games: games)
  end

  def teardown
    @match = nil
  end

  test "should have player one" do
    assert(@match.player1.id = 1)
  end

  test "should have player two" do
    assert(@match.player2.id = 2)
  end

  test "should have no winner" do
    @match.games.first.player1_score = 0
    @match.games.first.player2_score = 11

    # Match is tied 1-1, there is no winner
    assert_not(@match.save, "Should not save")
    assert_equal(@match.errors[:base], ["Match does not have a winner. A player must win 2 out of 3 games."],
      "Should provide error message for lack of winner")
  end

  test "should have two or three games" do
    @match.games = [Game.new(player1_id: 1, player2_id: 2, player1_score: 11, player2_score: 0)]

    # Match only has one game played, should throw an error
    assert_not(@match.save, "Should not save")
    assert_equal(@match.errors[:base], ["Matches must contain two or three games."],
      "Should provide error message - not enough games played.")
  end

  test "should have winner and loser" do

    # Player One wins 2-0 in our setup method
    assert(@match.errors.none?, "There should be errors")
    assert_equal(@match.winner.id, 1, "Match's winner should be player one'")
    assert_equal(@match.loser.id, 2, "Match's loser should be player two")
  end
end
