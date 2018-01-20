require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
    
    def setup
        @userAdmin = user_admins(:nomequalsiasiadmin)
        @userProfessore = user_professores(:nomequalsiasiprofessore)
        @userStudente = user_studentes(:nomequalsiasistudente)
    end
    
    test "login with invalid information" do
        get login_path
        assert_template 'sessions/new'
        post login_path, session: { email: "", password: "" }
        assert_template 'sessions/new'
        assert_not flash.empty?
        get root_path
        assert flash.empty?
    end
    
    test "login with valid information for an admin user" do
        get login_path
        post login_path, session: { email: @userAdmin.email, password: 'password' }
        assert_redirected_to @userAdmin
        follow_redirect!
        assert_template 'user_admins/show'
        assert_select "a[href=?]", paginaIniziale_path, count: 0
        assert_select "a[href=?]", logout_path
        assert_select "a[href=?]", user_admin_path(@userAdmin)
    end
    
    test "login with valid information for a professor user" do
        get login_path
        post login_path, session: { email: @userProfessore.email, password: 'password' }
        assert_redirected_to @userProfessore
        follow_redirect!
        assert_template 'user_professores/show'
        assert_select "a[href=?]", paginaIniziale_path, count: 0
        assert_select "a[href=?]", logout_path
        assert_select "a[href=?]", user_professore_path(@userProfessore)
    end
    
    test "login with valid information for a student user" do
        get login_path
        post login_path, session: { email: @userStudente.email, password: 'password' }
        assert_redirected_to @userStudente
        follow_redirect!
        assert_template 'user_studentes/show'
        assert_select "a[href=?]", paginaIniziale_path, count: 0
        assert_select "a[href=?]", logout_path
        assert_select "a[href=?]", user_studente_path(@userStudente)
    end

end
