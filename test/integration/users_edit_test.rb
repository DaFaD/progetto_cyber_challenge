require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
    def setup
        @userAdmin = user_admins(:nomequalsiasiadmin)
        @userProfessore = user_professores(:nomequalsiasiprofessore)
        @userStudente = user_studentes(:nomequalsiasistudente)
    end
    
    test "unsuccessful edit for an admin user" do
        get edit_user_admin_path(@userAdmin)
        assert_template 'user_admins/edit'
        patch user_admin_path(@userAdmin), user_admin: { name: "", surname: "", email: "foo@invalid", username: "", password: "foo", password_confirmation: "bar" }
        assert_template 'user_admins/edit'
    end
    
    test "unsuccessful edit for a professor user" do
        get edit_user_professore_path(@userProfessore)
        assert_template 'user_professores/edit'
        patch user_professore_path(@userProfessore), user_professore: { name: "", surname: "", email: "foo@invalid", username: "", password: "foo", password_confirmation: "bar" }
        assert_template 'user_professores/edit'
    end
    
    test "unsuccessful edit for a student user" do
        get edit_user_studente_path(@userStudente)
        assert_template 'user_studentes/edit'
        patch user_studente_path(@userStudente), user_studente: { name: "", surname: "", email: "foo@invalid", username: "", fiscalCode: "", birthDay: Date.new(2000, 6, 4), password: "foo", password_confirmation: "bar" }
        assert_template 'user_studentes/edit'
    end
end
