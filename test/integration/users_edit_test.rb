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
        log_in_as(@userAdmin)
        get edit_user_admin_path(@userAdmin)
        assert_template 'user_admins/edit'
        patch user_admin_path(@userAdmin), user_admin: { name: "", surname: "", email: "foo@invalid", username: "", password: "foo", password_confirmation: "bar" }
        assert_template 'user_admins/edit'
    end
    
    test "unsuccessful edit for a professor user" do
        log_in_as(@userProfessore)
        get edit_user_professore_path(@userProfessore)
        assert_template 'user_professores/edit'
        patch user_professore_path(@userProfessore), user_professore: { name: "", surname: "", email: "foo@invalid", username: "", password: "foo", password_confirmation: "bar" }
        assert_template 'user_professores/edit'
    end
    
    test "unsuccessful edit for a student user" do
        log_in_as(@userStudente)
        get edit_user_studente_path(@userStudente)
        assert_template 'user_studentes/edit'
        patch user_studente_path(@userStudente), user_studente: { name: "", surname: "", email: "foo@invalid", username: "", fiscalCode: "", birthDay: Date.new(2000, 6, 4), password: "foo", password_confirmation: "bar" }
        assert_template 'user_studentes/edit'
    end
    
    test "successful edit for an admin user" do
        log_in_as(@userAdmin)
        get edit_user_admin_path(@userAdmin)
        assert_template 'user_admins/edit'
        name = "Foo"
        surname= "Bar"
        username= "BarFooAdmin"
        patch user_admin_path(@userAdmin), user_admin: { name: name, surname: surname, username: username, password: "", password_confirmation: "" }
        assert_not flash.empty?
        assert_redirected_to @userAdmin
        @userAdmin.reload
        assert_equal @userAdmin.name, name
        assert_equal @userAdmin.surname, surname
        assert_equal @userAdmin.username, username.downcase
    end
    
    test "successful edit for a professor user" do
        log_in_as(@userProfessore)
        get edit_user_professore_path(@userProfessore)
        assert_template 'user_professores/edit'
        name = "Foo"
        surname= "Bar"
        username= "BarFooProfessore"
        patch user_professore_path(@userProfessore), user_professore: { name: name, surname: surname, username: username, password: "", password_confirmation: "" }
        assert_not flash.empty?
        assert_redirected_to @userProfessore
        @userProfessore.reload
        assert_equal @userProfessore.name, name
        assert_equal @userProfessore.surname, surname
        assert_equal @userProfessore.username, username.downcase
    end
    
    test "successful edit for a student user" do
        log_in_as(@userStudente)
        get edit_user_studente_path(@userStudente)
        assert_template 'user_studentes/edit'
        name = "Foo"
        surname= "Bar"
        username= "BarFooStudente"
        fiscalCode= "BRAFOO99B19H501Q"
        birthDay= Date.new(1999, 2, 12)
        patch user_studente_path(@userStudente), user_studente: { name: name, surname: surname, username: username, fiscalCode: fiscalCode, birthDay: birthDay, password: "", password_confirmation: "" }
        assert_not flash.empty?
        assert_redirected_to @userStudente
        @userStudente.reload
        assert_equal @userStudente.name, name
        assert_equal @userStudente.surname, surname
        assert_equal @userStudente.username, username.downcase
        assert_equal @userStudente.fiscalCode, fiscalCode.downcase
        assert_equal @userStudente.birthDay, birthDay
    end
    
    test "successful edit with friendly forwarding for an admin user" do
        get edit_user_admin_path(@userAdmin)
        log_in_as(@userAdmin)
        assert_redirected_to edit_user_admin_path(@userAdmin)
        name = "Foo"
        surname= "Bar"
        username= "BarFooAdmin"
        patch user_admin_path(@userAdmin), user_admin: { name: name, surname: surname, username: username, password: "", password_confirmation: "" }
        assert_not flash.empty?
        assert_redirected_to @userAdmin
        @userAdmin.reload
        assert_equal @userAdmin.name, name
        assert_equal @userAdmin.surname, surname
        assert_equal @userAdmin.username, username.downcase
    end
    
    test "successful edit with friendly forwarding for a professor user" do
        get edit_user_professore_path(@userProfessore)
        log_in_as(@userProfessore)
        assert_redirected_to edit_user_professore_path(@userProfessore)
        name = "Foo"
        surname= "Bar"
        username= "BarFooProfessore"
        patch user_professore_path(@userProfessore), user_professore: { name: name, surname: surname, username: username, password: "", password_confirmation: "" }
        assert_not flash.empty?
        assert_redirected_to @userProfessore
        @userProfessore.reload
        assert_equal @userProfessore.name, name
        assert_equal @userProfessore.surname, surname
        assert_equal @userProfessore.username, username.downcase
    end
    
    test "successful edit with friendly forwarding for a student user" do
        get edit_user_studente_path(@userStudente)
        log_in_as(@userStudente)
        assert_redirected_to edit_user_studente_path(@userStudente)
        name = "Foo"
        surname= "Bar"
        username= "BarFooStudente"
        fiscalCode= "BRAFOO99B19H501Q"
        birthDay= Date.new(1999, 2, 12)
        patch user_studente_path(@userStudente), user_studente: { name: name, surname: surname, username: username, fiscalCode: fiscalCode, birthDay: birthDay, password: "", password_confirmation: "" }
        assert_not flash.empty?
        assert_redirected_to @userStudente
        @userStudente.reload
        assert_equal @userStudente.name, name
        assert_equal @userStudente.surname, surname
        assert_equal @userStudente.username, username.downcase
        assert_equal @userStudente.fiscalCode, fiscalCode.downcase
        assert_equal @userStudente.birthDay, birthDay
    end
end
