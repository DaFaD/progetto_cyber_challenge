require 'test_helper'

class UserProfessoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @userProfessore = UserProfessore.new(name: "Matteo", surname: "Vari", email: "mattew98.01@dis.uniroma1.it", username: "Mattew98-01", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @userProfessore.valid?
  end
  
  test "name should be present" do
    @userProfessore.name = "    "
    assert_not @userProfessore.valid?
  end
  
  test "surname should be present" do
    @userProfessore.surname = ""
    assert_not @userProfessore.valid?
  end
  
  test "email should be present" do
    @userProfessore.email = " "
    assert_not @userProfessore.valid?
  end
  
  test "username should be present" do
    @userProfessore.username = " "
    assert_not @userProfessore.valid?
  end
  
  test "name should not be too long" do
    @userProfessore.name = "a" * 51
    assert_not @userProfessore.valid?
  end
  
  test "surname should not be too long" do
    @userProfessore.surname = "a" * 51
    assert_not @userProfessore.valid?
  end
  
  test "email should not be too long" do
    @userProfessore.email = "a" * 240 + "@dis.uniroma1.it"
    assert_not @userProfessore.valid?
  end
  
  test "username should not be too long" do
    @userProfessore.username = "a" * 51
    assert_not @userProfessore.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[nome.cognome@uniroma1.it cognome@dis.uniroma1.it cognome@uniroma1.it nome.cognome@dis.uniroma1.it]
    valid_addresses.each do |valid_address|
        @userProfessore.email = valid_address
        assert @userProfessore.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com utente@hotmail.it utente@live.com nome.cognome@alice.com utente@gmail..com. utente@gmail.it utente@gmail.com cognome.1736273@studenti.uniroma1.it]
    invalid_addresses.each do |invalid_address|
        @userProfessore.email = invalid_address
        assert_not @userProfessore.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    altroProfessore = UserProfessore.new(name: "Gianfranco", surname: "Verdi", email: "mattew98.01@dis.uniroma1.it", username: "Giangi", password: "foobar2", password_confirmation: "foobar2")
    @userProfessore.save
    assert_not altroProfessore.valid?
  end
  
  test "email addresses should be unique (case-insensitive)" do
    altroProfessore = UserProfessore.new(name: "Gianfranco", surname: "Verdi", email: "mattew98.01@dis.uniroma1.it", username: "Giangi", password: "foobar2", password_confirmation: "foobar2")
    altroProfessore.email = @userProfessore.email.upcase
    @userProfessore.save
    assert_not altroProfessore.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@UnIRomA1.iT"
    @userProfessore.email = mixed_case_email
    @userProfessore.save
    assert_equal mixed_case_email.downcase, @userProfessore.reload.email
  end
  
  test "usernames should be unique" do
    altroProfessore = UserProfessore.new(name: "Gianfranco", surname: "Verdi", email: "giangi@uniroma1.it", username: "Mattew98-01", password: "foobar2", password_confirmation: "foobar2")
    @userProfessore.save
    assert_not altroProfessore.valid?
  end
  
  test "usernames should be unique (case-insensitive)" do
    altroProfessore = UserProfessore.new(name: "Gianfranco", surname: "Verdi", email: "giangi@uniroma1.it", username: "Mattew98-01", password: "foobar2", password_confirmation: "foobar2")
    altroProfessore.username = @userProfessore.username.upcase
    @userProfessore.save
    assert_not altroProfessore.valid?
  end
  
  test "usernames should be saved as lower-case" do
    mixed_case_username = "PrOVa"
    @userProfessore.username = mixed_case_username
    @userProfessore.save
    assert_equal mixed_case_username.downcase, @userProfessore.reload.username
  end
  
  test "password should have a minimum length of 6 characters" do
    @userProfessore.password = @userProfessore.password_confirmation = "a" * 5
    assert_not @userProfessore.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @userProfessore.authenticated?('')
  end
end
