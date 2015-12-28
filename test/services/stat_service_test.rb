require 'test_helper'

class StatServiceTest < ActionController::TestCase
  def setup
    @match = Match.first
    @wins = @match.winner.wins
    @losses = @match.loser.losses

    @stat_service = StatService.new({
      match: @match,
      winner: @match.winner,
      loser: @match.loser
    })
  end

  def teardown
    @stat_service = nil
  end

  test "should increase wins and losses by one" do
    @stat_service.update_stats
    assert_equal(@match.winner.wins, @wins + 1, "Winner should have one more win")
    assert_equal(@match.loser.losses, @losses + 1, "Loser should have one more loss")
  end

  test "should decrease wins and losses by one" do
    @stat_service.update_stats_for_deleted_match
    assert_equal(@match.winner.wins, @wins - 1, "Winner should have one less win")
    assert_equal(@match.loser.losses, @losses - 1, "Loser should have one less loss")
  end

  test "should update stats for new winner" do
    winner_losses = @match.winner.losses
    loser_wins = @match.loser.wins

    @stat_service.update_stats_for_match_with_new_winner
    assert_equal(@match.winner.wins, @wins - 1, "Winner should have one less win")
    assert_equal(@match.winner.losses, winner_losses + 1, "Winner should have one more loss")
    assert_equal(@match.loser.losses, @losses - 1, "Loser should have one less loss")
    assert_equal(@match.loser.wins, loser_wins + 1, "Loser should have one more win")
  end
end
