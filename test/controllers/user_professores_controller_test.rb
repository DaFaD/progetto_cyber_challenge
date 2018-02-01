require 'test_helper'

class UserProfessoresControllerTest < ActionController::TestCase

  def setup
    @userProfessore = user_professores(:nomequalsiasiprofessore)
    @userProfessore2 = user_professores(:nomequalsiasiprofessore2)
    @userStudente = user_studentes(:nomequalsiasistudente)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  #test "should get new" do
    #get :new
    #assert_response :success
  #end

  test "should redirect edit when not logged in" do
    get :edit, id: @userProfessore
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @userProfessore, user_professore: { name: @userProfessore.name, surname: @userProfessore.surname, email: @userProfessore.email, username: @userProfessore.username }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect show when not logged in" do
    get :show, id: @userProfessore
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@userProfessore2)
    get :edit, id: @userProfessore
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@userProfessore2)
    patch :update, id: @userProfessore, user_professore: { name: @userProfessore.name, surname: @userProfessore.surname, email: @userProfessore.email, username: @userProfessore.username }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when not logged in and trying to delete a professor user" do
    assert_no_difference 'UserProfessore.count' do
        delete :destroy, id: @userProfessore
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when logged in as a non-admin (as a professor) and trying to delete a professor user" do
    log_in_as(@userProfessore2)
    assert_no_difference 'UserProfessore.count' do
        delete :destroy, id: @userProfessore
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when logged in as a non-admin (as a student) and trying to delete a professor user" do
    log_in_as(@userStudente)
    assert_no_difference 'UserProfessore.count' do
        delete :destroy, id: @userProfessore
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
