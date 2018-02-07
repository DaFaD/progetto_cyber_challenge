require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
    def setup
        ActionMailer::Base.deliveries.clear
    end
  
    test "invalid signup information for an admin user" do
        get '/signupAdmin'
        assert_no_difference 'UserAdmin.count' do
            post user_admins_path, user_admin: { name: "", surname: "", email: "user@invalid", username: "", password: "foo", password_confirmation: "bar", administrator_password: "password" }
        end
        assert_template 'user_admins/new'
    end
    
    test "invalid signup information for a professor user" do
        get '/signupProfessore'
        assert_no_difference 'UserProfessore.count' do
            post user_professores_path, user_professore: { name: "", surname: "", email: "user@invalid", username: "", password: "foo", password_confirmation: "bar", professor_password: "password" }
        end
        assert_template 'user_professores/new'
    end
    
    test "invalid signup information for a student user" do
        get '/signupStudente'
        assert_no_difference 'UserStudente.count' do
            post user_studentes_path, user_studente: { name: "", surname: "", email: "user@invalid", username: "", fiscalCode: "", birthDay: Date.new(2000, 6, 4), password: "foo", password_confirmation: "bar" }
        end
        assert_template 'user_studentes/new'
    end
    
    test "valid signup information for an admin user" do
        get '/signupAdmin'
        assert_difference 'UserAdmin.count', 1 do
            post_via_redirect user_admins_path, user_admin: { name: "Nome", surname: "Cognome", email: "nome.cognome@hotmail.it", username: "Soprannome", password: "foobar", password_confirmation: "foobar", administrator_password: "password" }
        end
    end
    
    test "valid signup information for a professor user" do
        get '/signupProfessore'
        assert_difference 'UserProfessore.count', 1 do
            post_via_redirect user_professores_path, user_professore: { name: "Nome", surname: "Cognome", email: "cognome@uniroma1.it", username: "Soprannome", password: "foobar", password_confirmation: "foobar", professor_password: "password" }
        end
    end
    
    test "valid signup information for a student user" do
        get '/signupStudente'
        assert_difference 'UserStudente.count', 1 do
            post_via_redirect user_studentes_path, user_studente: { name: "Nome", surname: "Cognome", email: "cognome.1656284@studenti.uniroma1.it", username: "Soprannome", fiscalCode: "CGNNMO00H04H501T", birthDay: Date.new(2000, 6, 4), password: "foobar", password_confirmation: "foobar" }
        end
    end
    
    test "valid signup information with account activation for an admin user" do
        get signupAdmin_path
        assert_difference 'UserAdmin.count', 1 do
            post user_admins_path, user_admin: { name: "Nome", surname: "Cognome", email: "nome.cognome@hotmail.it", username: "Soprannome", password: "foobar", password_confirmation: "foobar", administrator_password: "password" }
        end
        assert_equal 1, ActionMailer::Base.deliveries.size
        user = assigns(:userAdmin)
        assert_not user.activated?
        # Try to log in before activation.
        log_in_as(user)
        assert_not is_logged_in?
        # Invalid activation token
        get edit_account_activation_path("invalid token")
        assert_not is_logged_in?
        # Valid token, wrong email
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        assert_not is_logged_in?
        # Valid activation token
        get edit_account_activation_path(user.activation_token, email: user.email)
        #assert user.reload.activated?
        #follow_redirect!
        #assert_template 'user_admins/show'
        #assert is_logged_in?
    end
    
    test "valid signup information with account activation for a professor user" do
        get signupProfessore_path
        assert_difference 'UserProfessore.count', 1 do
            post user_professores_path, user_professore: { name: "Nome", surname: "Cognome", email: "cognome@uniroma1.it", username: "Soprannome", password: "foobar", password_confirmation: "foobar", professor_password: "password" }
        end
        assert_equal 1, ActionMailer::Base.deliveries.size
        user = assigns(:userProfessore)
        assert_not user.activated?
        # Try to log in before activation.
        log_in_as(user)
        assert_not is_logged_in?
        # Invalid activation token
        get edit_account_activation_path("invalid token")
        assert_not is_logged_in?
        # Valid token, wrong email
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        assert_not is_logged_in?
        # Valid activation token
        get edit_account_activation_path(user.activation_token, email: user.email)
        #assert user.reload.activated?
        #follow_redirect!
        #assert_template 'user_professores/show'
        #assert is_logged_in?
    end
    
    test "valid signup information with account activation for a student user" do
        get signupStudente_path
        assert_difference 'UserStudente.count', 1 do
            post user_studentes_path, user_studente: { name: "Nome", surname: "Cognome", email: "cognome.1656284@studenti.uniroma1.it", username: "Soprannome", fiscalCode: "CGNNMO00H04H501T", birthDay: Date.new(2000, 6, 4), password: "foobar", password_confirmation: "foobar" }
        end
        assert_equal 1, ActionMailer::Base.deliveries.size
        user = assigns(:userStudente)
        assert_not user.activated?
        # Try to log in before activation.
        log_in_as(user)
        assert_not is_logged_in?
        # Invalid activation token
        get edit_account_activation_path("invalid token")
        assert_not is_logged_in?
        # Valid token, wrong email
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        assert_not is_logged_in?
        # Valid activation token
        get edit_account_activation_path(user.activation_token, email: user.email)
        #assert user.reload.activated?
        #follow_redirect!
        #assert_template 'user_studentes/show'
        #assert is_logged_in?
    end
end
