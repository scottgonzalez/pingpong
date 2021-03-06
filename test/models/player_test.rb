require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "should require name" do
    player = Player.new
    assert_equal(player.save, false, "Should not save")
    assert_equal(player.errors[:name], ["can't be blank"],
      "Should provide error message for name")
  end

  test "should create player" do
    player = Player.new(name: "John")
    assert_equal(player.save, true, "Should save player")
    assert_equal(player.wins, 0, "Should default to 0 wins")
    assert_equal(player.losses, 0, "Should default to 0 losses")
  end

  test "should require unique name" do
    player1 = Player.new(name: "John")
    assert_equal(player1.save, true, "Should save first player")

    player2 = Player.new(name: "John")
    assert_equal(player2.save, false, "Should not save second player");
    assert_equal(player2.errors[:name], ["has already been taken"],
      "Should provide error message for name")
  end
end
