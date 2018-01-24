require 'test_helper'

class UserStudentesControllerTest < ActionController::TestCase

  def setup
    @userStudente = user_studentes(:nomequalsiasistudente)
    @userStudente2 = user_studentes(:nomequalsiasistudente2)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @userStudente
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @userStudente, user_studente: { name: @userStudente.name, surname: @userStudente.surname, email: @userStudente.email, username: @userStudente.username, fiscalCode: @userStudente.fiscalCode, birthDay: @userStudente.birthDay }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect show when not logged in" do
    get :show, id: @userStudente
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@userStudente2)
    get :edit, id: @userStudente
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@userStudente2)
    patch :update, id: @userStudente, user_studente: { name: @userStudente.name, surname: @userStudente.surname, email: @userStudente.email, username: @userStudente.username, fiscalCode: @userStudente.fiscalCode, birthDay: @userStudente.birthDay }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
