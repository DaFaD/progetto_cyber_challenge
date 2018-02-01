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

  #test "password_reset" do
    #mail = UserMailer.password_reset
    #assert_equal "Password reset", mail.subject
    #assert_equal ["to@example.org"], mail.to
    #assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  #end

end
