class UserAdmin < ActiveRecord::Base
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    before_save { self.username = username.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    validates :surname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }, allow_blank: true
    
    # Returns the hash digest of the given string.
    def UserAdmin.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token.
    def UserAdmin.new_token
        SecureRandom.urlsafe_base64
    end
    
    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = UserAdmin.new_token
        update_attribute(:remember_digest, UserAdmin.digest(remember_token))
    end
    
    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end
end
