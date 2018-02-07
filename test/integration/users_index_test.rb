require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
    def setup
        @userAdmin = user_admins(:nomequalsiasiadmin)
        @userAdmin2 = user_admins(:nomequalsiasiadmin2)
        @userProfessore = user_professores(:nomequalsiasiprofessore)
        @userStudente = user_studentes(:nomequalsiasistudente)
    end
    
    test "index of admin users including pagination for an admin user" do
        log_in_as(@userAdmin)
        get user_admins_path
        assert_template 'user_admins/index'
        assert_select 'div.digg_pagination'
        UserAdmin.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_admin_path(user), text: user.username
        end
    end
    
    test "index of admin users including pagination for a professor user" do
        log_in_as(@userProfessore)
        get user_admins_path
        assert_template 'user_admins/index'
        assert_select 'div.digg_pagination'
        UserAdmin.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_admin_path(user), text: user.username
        end
    end
    
    test "index of admin users including pagination for a student user" do
        log_in_as(@userStudente)
        get user_admins_path
        assert_template 'user_admins/index'
        assert_select 'div.digg_pagination'
        UserAdmin.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_admin_path(user), text: user.username
        end
    end
    
    test "index of professor users including pagination for an admin user" do
        log_in_as(@userAdmin)
        get user_professores_path
        assert_template 'user_professores/index'
        assert_select 'div.digg_pagination'
        UserProfessore.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_professore_path(user), text: user.username
        end
    end
    
    test "index of professor users including pagination for a professor user" do
        log_in_as(@userProfessore)
        get user_professores_path
        assert_template 'user_professores/index'
        assert_select 'div.digg_pagination'
        UserProfessore.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_professore_path(user), text: user.username
        end
    end
    
    test "index of professor users including pagination for a student user" do
        log_in_as(@userStudente)
        get user_professores_path
        assert_template 'user_professores/index'
        assert_select 'div.digg_pagination'
        UserProfessore.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_professore_path(user), text: user.username
        end
    end
    
    test "index of student users including pagination for an admin user" do
        log_in_as(@userAdmin)
        get user_studentes_path
        assert_template 'user_studentes/index'
        assert_select 'div.digg_pagination'
        UserStudente.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_studente_path(user), text: user.username
        end
    end
    
    test "index of student users including pagination for a professor user" do
        log_in_as(@userProfessore)
        get user_studentes_path
        assert_template 'user_studentes/index'
        assert_select 'div.digg_pagination'
        UserStudente.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_studente_path(user), text: user.username
        end
    end
    
    test "index of student users including pagination for a student user" do
        log_in_as(@userStudente)
        get user_studentes_path
        assert_template 'user_studentes/index'
        assert_select 'div.digg_pagination'
        UserStudente.paginate(page: 1).order('username').each do |user|
            assert_select 'a[href=?]', user_studente_path(user), text: user.username
        end
    end
    
    test "admins' index as admin including pagination and delete links" do
        log_in_as(@userAdmin)
        get user_admins_path
        assert_template 'user_admins/index'
        assert_select 'div.digg_pagination'
        first_page_of_user_admins = UserAdmin.paginate(page: 1).order('username')
        first_page_of_user_admins.each do |user|
            assert_select 'a[href=?]', user_admin_path(user), text: user.username
            unless user == @userAdmin
                assert_select 'a[href=?]', user_admin_path(user), text: 'delete', method: :delete
            end
        end
        assert_difference 'UserAdmin.count', -1 do
            delete user_admin_path(@userAdmin2)
        end
    end

    test "admins' index as non-admin (as a professor)" do
        log_in_as(@userProfessore)
        get user_admins_path
        assert_select 'a', text: 'delete', count: 0
    end
    
    test "admins' index as non-admin (as a student)" do
        log_in_as(@userStudente)
        get user_admins_path
        assert_select 'a', text: 'delete', count: 0
    end
    
    test "professors' index as admin including pagination and delete links" do
        log_in_as(@userAdmin)
        get user_professores_path
        assert_template 'user_professores/index'
        assert_select 'div.digg_pagination'
        first_page_of_user_professores = UserProfessore.paginate(page: 1).order('username')
        first_page_of_user_professores.each do |user|
            assert_select 'a[href=?]', user_professore_path(user), text: user.username
            unless user == @userAdmin
                assert_select 'a[href=?]', user_professore_path(user), text: 'delete', method: :delete
            end
        end
        assert_difference 'UserProfessore.count', -1 do
            delete user_professore_path(@userProfessore)
        end
    end

    test "professors' index as non-admin (as a professor)" do
        log_in_as(@userProfessore)
        get user_professores_path
        assert_select 'a', text: 'delete', count: 0
    end
    
    test "professors' index as non-admin (as a student)" do
        log_in_as(@userStudente)
        get user_professores_path
        assert_select 'a', text: 'delete', count: 0
    end
    
    test "students' index as admin including pagination and delete links" do
        log_in_as(@userAdmin)
        get user_studentes_path
        assert_template 'user_studentes/index'
        assert_select 'div.digg_pagination'
        first_page_of_user_studentes = UserStudente.paginate(page: 1).order('username')
        first_page_of_user_studentes.each do |user|
            assert_select 'a[href=?]', user_studente_path(user), text: user.username
            unless user == @userAdmin
                assert_select 'a[href=?]', user_studente_path(user), text: 'delete', method: :delete
            end
        end
        assert_difference 'UserStudente.count', -1 do
            delete user_studente_path(@userStudente)
        end
    end

    test "students' index as non-admin (as a professor)" do
        log_in_as(@userProfessore)
        get user_studentes_path
        assert_select 'a', text: 'delete', count: 0
    end
    
    test "students' index as non-admin (as a student)" do
        log_in_as(@userStudente)
        get user_studentes_path
        assert_select 'a', text: 'delete', count: 0
    end
end
