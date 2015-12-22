require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "should get error creating player with no name" do
    player = Player.new
    player.save

    # Player's name is nil - should fail
    assert(player.errors[:name].any?)
  end

  test "should create valid player" do
    player = Player.new
    player.name = "Test Player"
    player.save

    # Player has a name, it should be validated
    assert(player.errors[:name].none?)
  end
end
