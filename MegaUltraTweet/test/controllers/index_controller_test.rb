require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get hashtag" do
    get :hashtag
    assert_response :success
  end

  test "should get twitterHandle" do
    get :twitterHandle
    assert_response :success
  end

  test "should get twitterUser" do
    get :twitterUser
    assert_response :success
  end

end
