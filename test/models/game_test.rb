require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "should require score for player1" do
    game = setup
    game.player1_score = nil

    # Game doesn't have a score for player 1
    assert_not(game.save, "Should not save game")
    assert(game.errors[:player1_score].any? ,"Should be errors")
  end

  test "should require score for player2" do
    game = setup
    game.player2_score = nil

    # Game doesn't have a score for player 2
    assert_not(game.save, "Should not save game")
    assert(game.errors[:player2_score].any?, "Should be errors")
  end

  test "should have a player with 11 points" do
    game = setup
    game.player1_score = 1
    game.player2_score = 1

    # If neither player has 11 points, there is no winner
    assert_not(game.save, "Should not save game")
    assert_equal(game.errors[:score], ["must be at least 11 points."],
      "Should provide error message for score")
  end

  test "should win by at least two" do
    game = setup
    game.player2_score = 10

    # Winner of the game must win by two
    assert_not(game.save, "Should not save game")
    assert_equal(game.errors[:score], ["must be won by at least two points."],
      "Should provide error message for score")
  end

  test "should win by exactly two in overtime" do
    game = setup
    game.player1_score = 14
    game.player2_score = 11

    # If overtime, must win by exactly two points
    assert_not(game.save, "Should not save game")
    assert_equal(game.errors[:score], ["must be won by exactly two points in overtime."],
      "Should provide error message for score")
  end

  private

  def setup
    game = Game.new
    game.player1_id = 1
    game.player2_id = 2
    game.player1_score = 11
    game.player2_score = 9
    return game
  end
end
