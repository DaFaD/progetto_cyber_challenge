class UserStudente < ActiveRecord::Base
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    before_save { self.username = username.downcase }
    before_save { self.fiscalCode = fiscalCode.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    validates :surname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@(gmail.it|gmail.com|studenti.uniroma1.it)\z/i # /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
    VALID_FISCALCODE_REGEX = /\A(?:[B-DF-HJ-NP-TV-Z](?:[AEIOU]{2}|[AEIOU]X)|[AEIOU]{2}X|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[1256LMRS][\dLMNP-V])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[\dLMNP-V][1-9MNP-V]|[1-9MNP-V][0L]))[A-Z]\z/i
    validates :fiscalCode, presence: true, length: { maximum: 16, minimum: 16 }, format: { with: VALID_FISCALCODE_REGEX }, uniqueness: { case_sensitive: false }
    validates :birthDay, presence: true
    has_secure_password
    validates :password, length: { minimum: 6 }
    
    # Returns the hash digest of the given string.
    def UserStudente.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token.
    def UserStudente.new_token
        SecureRandom.urlsafe_base64
    end
    
    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = UserStudente.new_token
        update_attribute(:remember_digest, UserStudente.digest(remember_token))
    end
    
    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end
end
