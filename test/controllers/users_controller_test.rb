require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get newStudente" do
    get :newStudente
    assert_response :success
  end
  
  test "should get newProfessore" do
    get :newProfessore
    assert_response :success
  end
  
  test "should get newAdmin" do
    get :newAdmin
    assert_response :success
  end
end
