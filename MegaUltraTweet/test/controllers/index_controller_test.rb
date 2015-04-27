require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get start" do
    get :get_tweets
    assert_response :success
  end

  test "should get finde" do
    get :find
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get search" do
    get :search_simple
    assert_response :success
  end
end
