class Otp < ActiveRecord::Base

    # Returns the hash digest of the given string.
    def Otp.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token.
    def Otp.new_token
        SecureRandom.urlsafe_base64
    end
    
    def Otp.createOtp(user)
        otp= Otp.new_token.to_s[0,9]
        otpDigest= Otp.digest(otp)
        if Otp.find_by(id_user: user.id) == nil
            Otp.create(id_user: user.id, otp_digest: otpDigest)
        else
            Otp.find_by(id_user: user.id).update_attributes(otp_digest: otpDigest)
        end
        otp
    end
    
    # Returns true if the given token matches the digest.
    def authenticated?(token)
        digest = self.otp_digest
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
end
