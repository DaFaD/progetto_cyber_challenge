require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
    def setup
        @userAdmin = user_admins(:nomequalsiasiadmin)
        @userProfessore = user_professores(:nomequalsiasiprofessore)
        @userStudente = user_studentes(:nomequalsiasistudente)
    end
    
    test "index of admin users including pagination for an admin user" do
        log_in_as(@userAdmin)
        get user_admins_path
        assert_template 'user_admins/index'
        assert_select 'div.digg_pagination'
        UserAdmin.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_admin_path(user), text: user.username
        end
    end
    
    test "index of admin users including pagination for a professor user" do
        log_in_as(@userProfessore)
        get user_admins_path
        assert_template 'user_admins/index'
        assert_select 'div.digg_pagination'
        UserAdmin.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_admin_path(user), text: user.username
        end
    end
    
    test "index of admin users including pagination for a student user" do
        log_in_as(@userStudente)
        get user_admins_path
        assert_template 'user_admins/index'
        assert_select 'div.digg_pagination'
        UserAdmin.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_admin_path(user), text: user.username
        end
    end
    
    test "index of professor users including pagination for an admin user" do
        log_in_as(@userAdmin)
        get user_professores_path
        assert_template 'user_professores/index'
        assert_select 'div.digg_pagination'
        UserProfessore.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_professore_path(user), text: user.username
        end
    end
    
    test "index of professor users including pagination for a professor user" do
        log_in_as(@userProfessore)
        get user_professores_path
        assert_template 'user_professores/index'
        assert_select 'div.digg_pagination'
        UserProfessore.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_professore_path(user), text: user.username
        end
    end
    
    test "index of professor users including pagination for a student user" do
        log_in_as(@userStudente)
        get user_professores_path
        assert_template 'user_professores/index'
        assert_select 'div.digg_pagination'
        UserProfessore.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_professore_path(user), text: user.username
        end
    end
    
    test "index of student users including pagination for an admin user" do
        log_in_as(@userAdmin)
        get user_studentes_path
        assert_template 'user_studentes/index'
        assert_select 'div.digg_pagination'
        UserStudente.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_studente_path(user), text: user.username
        end
    end
    
    test "index of student users including pagination for a professor user" do
        log_in_as(@userProfessore)
        get user_studentes_path
        assert_template 'user_studentes/index'
        assert_select 'div.digg_pagination'
        UserStudente.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_studente_path(user), text: user.username
        end
    end
    
    test "index of student users including pagination for a student user" do
        log_in_as(@userStudente)
        get user_studentes_path
        assert_template 'user_studentes/index'
        assert_select 'div.digg_pagination'
        UserStudente.paginate(page: 1).each do |user|
            assert_select 'a[href=?]', user_studente_path(user), text: user.username
        end
    end
end
