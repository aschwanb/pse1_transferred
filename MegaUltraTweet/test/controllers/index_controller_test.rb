require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get finde" do
    get :finde
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end
end
