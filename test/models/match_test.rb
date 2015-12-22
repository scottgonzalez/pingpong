require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  test "winners" do
    assert_equal(Match.find(1).winner, Player.find(1), "Player one should win match one!")
    assert_equal(Match.find(2).winner, Player.find(3), "Player three should win match two!")
  end

  test "losers" do
    assert_equal(Match.find(1).loser, Player.find(2), "Player two should lose match one!")
    assert_equal(Match.find(2).loser, Player.find(4), "Player four should lose match two!")
  end
end
