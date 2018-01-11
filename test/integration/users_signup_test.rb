require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
    test "invalid signup information for an admin user" do
        get '/signupAdmin'
        assert_no_difference 'UserAdmin.count' do
            post user_admins_path, user_admin: { name: "", surname: "", email: "user@invalid", username: "", password: "foo", password_confirmation: "bar" }
        end
        assert_template 'user_admins/new'
    end
    
    test "invalid signup information for a professor user" do
        get '/signupProfessore'
        assert_no_difference 'UserProfessore.count' do
            post user_professores_path, user_professore: { name: "", surname: "", email: "user@invalid", username: "", password: "foo", password_confirmation: "bar" }
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
end
