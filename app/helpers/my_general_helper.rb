module MyGeneralHelper

    # return true if the user passed is an administrator, false otherwise
    def this_is_admin?(user)
        user.class.to_s == "UserAdmin"
    end
    
    # return true if the user passed is a professor, false otherwise
    def this_is_professore?(user)
        user.class.to_s == "UserProfessore"
    end
    
    # return true if the user passed is a student, false otherwise
    def this_is_studente?(user)
        user.class.to_s == "UserStudente"
    end
end
