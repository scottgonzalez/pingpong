require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new player" do
    get :new
    assert_response :success
    assert_not_nil assigns(:player)
  end

  test "should show player" do
    get(:show, { "id" => "1" })
    assert_response :success
    assert_not_nil assigns(:player)
    assert_not_nil assigns(:history)
  end

  test "should create player" do
    assert_difference("Player.count") do
      post :create, player: {name: "New Player"}
    end
    assert_redirected_to players_path
  end

end
