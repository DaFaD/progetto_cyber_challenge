require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

    def setup
        @userAdmin = user_admins(:nomequalsiasiadmin)
        remember(@userAdmin)
    end
    
    test "current_user returns right user when session is nil for an admin user" do
        assert_equal @userAdmin, current_user
        assert is_logged_in?
    end
    
    test "current_user returns nil when remember digest is wrong for an admin user" do
        @userAdmin.update_attribute(:remember_digest, UserAdmin.digest(UserAdmin.new_token))
        assert_nil current_user
    end
    
    test "current_user returns right user when session is nil for a professor user" do
        @userProfessore = user_professores(:nomequalsiasiprofessore)
        remember(@userProfessore)
        assert_equal @userProfessore, current_user
        assert is_logged_in?
    end
    
    test "current_user returns nil when remember digest is wrong for a professor user" do
        @userProfessore = user_professores(:nomequalsiasiprofessore)
        remember(@userProfessore)
        @userProfessore.update_attribute(:remember_digest, UserProfessore.digest(UserProfessore.new_token))
        assert_nil current_user
    end
    
    test "current_user returns right user when session is nil for a student user" do
        @userStudente = user_studentes(:nomequalsiasistudente)
        remember(@userStudente)
        assert_equal @userStudente, current_user
        assert is_logged_in?
    end
    
    test "current_user returns nil when remember digest is wrong for a student user" do
        @userStudente = user_studentes(:nomequalsiasistudente)
        remember(@userStudente)
        @userStudente.update_attribute(:remember_digest, UserStudente.digest(UserStudente.new_token))
        assert_nil current_user
    end
end
