require 'test_helper'

class UserAdminsControllerTest < ActionController::TestCase

  def setup
    @userAdmin = user_admins(:nomequalsiasiadmin)
    @userAdmin2 = user_admins(:nomequalsiasiadmin2)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @userAdmin
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @userAdmin, user_admin: { name: @userAdmin.name, surname: @userAdmin.surname, email: @userAdmin.email, username: @userAdmin.username }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect show when not logged in" do
    get :show, id: @userAdmin
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@userAdmin2)
    get :edit, id: @userAdmin
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@userAdmin2)
    patch :update, id: @userAdmin, user_admin: { name: @userAdmin.name, surname: @userAdmin.surname, email: @userAdmin.email, username: @userAdmin.username }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
