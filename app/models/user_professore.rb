class UserProfessore < ActiveRecord::Base
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save { self.email = email.downcase }
    before_save { self.username = username.downcase }
    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    validates :surname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A([\w+\-.]+@(diag.uniroma1.it|dis.uniroma1.it|uniroma1.it)|sinibaldi.1656495@studenti.uniroma1.it|daniel46-95@hotmail.it|daniel46.95@gmail.com)\z/i # versione precedente: /\A[\w+\-.]+@(dis.uniroma1.it|uniroma1.it)\z/i oppure una versione ancora precedente: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }, allow_blank: true
    
    # Returns the hash digest of the given string.
    def UserProfessore.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token.
    def UserProfessore.new_token
        SecureRandom.urlsafe_base64
    end
    
    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = UserProfessore.new_token
        update_attribute(:remember_digest, UserProfessore.digest(remember_token))
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
        self.reset_token = UserProfessore.new_token
        update_attribute(:reset_digest, UserProfessore.digest(reset_token))
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
            self.activation_token = UserProfessore.new_token
            self.activation_digest = UserProfessore.digest(activation_token)
        end
end
