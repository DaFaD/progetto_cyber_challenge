class UserStudente < ActiveRecord::Base
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save { self.email = email.downcase }
    before_save { self.username = username.downcase }
    before_save { self.fiscalCode = fiscalCode.downcase }
    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    validates :surname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@(gmail.it|gmail.com|studenti.uniroma1.it)\z/i # /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
    VALID_FISCALCODE_REGEX = /\A(?:[B-DF-HJ-NP-TV-Z](?:[AEIOU]{2}|[AEIOU]X)|[AEIOU]{2}X|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[1256LMRS][\dLMNP-V])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[\dLMNP-V][1-9MNP-V]|[1-9MNP-V][0L]))[A-Z]\z/i
    validates :fiscalCode, presence: true, length: { maximum: 16, minimum: 16 }, format: { with: VALID_FISCALCODE_REGEX }, uniqueness: { case_sensitive: false }
    validates :birthDay, presence: true
    has_secure_password
    validates :password, length: { minimum: 6 }, allow_blank: true
    
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
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end
    
    # Sets the password reset attributes.
    def create_reset_digest
        self.reset_token = UserStudente.new_token
        update_attribute(:reset_digest, UserStudente.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # Sends password reset email.
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end
    
    # Returns true if a password reset has expired.
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    private
    
        # Creates and assigns the activation token and digest.
        def create_activation_digest
            self.activation_token = UserStudente.new_token
            self.activation_digest = UserStudente.digest(activation_token)
        end
end
