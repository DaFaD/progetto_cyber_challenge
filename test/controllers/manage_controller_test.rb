require 'test_helper'

class ManageControllerTest < ActionController::TestCase

  def setup
    @userAdmin = user_admins(:nomequalsiasiadmin)
    @userProfessore = user_professores(:nomequalsiasiprofessore)
    @userStudente = user_studentes(:nomequalsiasistudente)
  end

  test "should get manage if you are an admin" do
    log_in_as(@userAdmin)
    get :manage
    assert_response :success
  end
  
  test "should get manage if you are a professor" do
    log_in_as(@userProfessore)
    get :manage
    assert_response :success
  end
  
  test "should get manage if you are a student" do
    log_in_as(@userStudente)
    get :manage
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should get manage if you aren't logged in" do
    get :manage
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
