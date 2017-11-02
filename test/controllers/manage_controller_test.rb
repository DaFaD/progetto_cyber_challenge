require 'test_helper'

class ManageControllerTest < ActionController::TestCase
  test "should get notice" do
    get :manage
    assert_response :success
  end

end
