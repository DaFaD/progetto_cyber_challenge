class PwNewProfessore < ActiveRecord::Base
    validates :pw, presence: true, length: { minimum: 6 }, allow_blank: true
    
    # Returns the hash digest of the given string.
    def PwNewProfessore.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns true if the given pw matches the current pw.
    def PwNewProfessore.right_pw?(given_pw)
        BCrypt::Password.new(PwNewProfessore.first.pw).is_password?(given_pw)
    end
end
