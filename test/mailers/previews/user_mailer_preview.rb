# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = UserAdmin.first
    user.activation_token = UserAdmin.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = UserAdmin.first
    user.reset_token = UserAdmin.new_token
    UserMailer.password_reset(user)
  end
  
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/send_otp
  def send_otp
    user = UserStudente.first
    otp= Otp.new_token.to_s[0,9]
    UserMailer.send_otp(user, otp)
  end

end
