require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation for an admin user" do
    user = user_admins(:nomequalsiasiadmin)
    user.activation_token = UserAdmin.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,
    mail.body.encoded
    assert_match user.surname,
    mail.body.encoded
    assert_match user.activation_token,
    mail.body.encoded
    assert_match CGI::escape(user.email),
    mail.body.encoded
    assert_match user.class.to_s, mail.body.encoded
  end
  
  test "account_activation for a professor user" do
    user = user_professores(:nomequalsiasiprofessore)
    user.activation_token = UserProfessore.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,
    mail.body.encoded
    assert_match user.surname,
    mail.body.encoded
    assert_match user.activation_token,
    mail.body.encoded
    assert_match CGI::escape(user.email),
    mail.body.encoded
    assert_match user.class.to_s, mail.body.encoded
  end
  
  test "account_activation for a student user" do
    user = user_studentes(:nomequalsiasistudente)
    user.activation_token = UserStudente.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,
    mail.body.encoded
    assert_match user.surname,
    mail.body.encoded
    assert_match user.activation_token,
    mail.body.encoded
    assert_match CGI::escape(user.email),
    mail.body.encoded
    assert_match user.class.to_s, mail.body.encoded
  end

  test "password_reset for an admin user" do
    user = user_admins(:nomequalsiasiadmin)
    user.reset_token = UserAdmin.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
    assert_match user.class.to_s, mail.body.encoded
  end
  
  test "password_reset for a professor user" do
    user = user_professores(:nomequalsiasiprofessore)
    user.reset_token = UserProfessore.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
    assert_match user.class.to_s, mail.body.encoded
  end
  
  test "password_reset for a student user" do
    user = user_studentes(:nomequalsiasistudente)
    user.reset_token = UserStudente.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
    assert_match user.class.to_s, mail.body.encoded
  end

end
