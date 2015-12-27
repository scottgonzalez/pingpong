require 'test_helper'

class PlayerHistoryServiceTest < ActionController::TestCase
  test "should get player history" do
    history = PlayerHistory.from_player(Player.find(1))
    assert_equal(history.length, 1, "Player one should have one match played")
  end
end
