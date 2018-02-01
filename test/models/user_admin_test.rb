require 'test_helper'

class UserAdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @userAdmin = UserAdmin.new(name: "Matteo", surname: "Vari", email: "mattew98.01@dis.uniroma1.it", username: "Mattew98-01", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @userAdmin.valid?
  end
  
  test "name should be present" do
    @userAdmin.name = "    "
    assert_not @userAdmin.valid?
  end
  
  test "surname should be present" do
    @userAdmin.surname = ""
    assert_not @userAdmin.valid?
  end
  
  test "email should be present" do
    @userAdmin.email = " "
    assert_not @userAdmin.valid?
  end
  
  test "username should be present" do
    @userAdmin.username = " "
    assert_not @userAdmin.valid?
  end
  
  test "name should not be too long" do
    @userAdmin.name = "a" * 51
    assert_not @userAdmin.valid?
  end
  
  test "surname should not be too long" do
    @userAdmin.surname = "a" * 51
    assert_not @userAdmin.valid?
  end
  
  test "email should not be too long" do
    @userAdmin.email = "a" * 240 + "@dis.uniroma1.it"
    assert_not @userAdmin.valid?
  end
  
  test "username should not be too long" do
    @userAdmin.username = "a" * 51
    assert_not @userAdmin.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[nome.cognome@uniroma1.it cognome@dis.uniroma1.it cognome@uniroma1.it nome.cognome@dis.uniroma1.it utente@gmail.it utente@gmail.com cognome.1736273@studenti.uniroma1.it utente@studenti.uniroma1.it utente@hotmail.it utente@live.com nome.cognome@alice.com]
    valid_addresses.each do |valid_address|
        @userAdmin.email = valid_address
        assert @userAdmin.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com utente@gmail..com.]
    invalid_addresses.each do |invalid_address|
        @userAdmin.email = invalid_address
        assert_not @userAdmin.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    altroAdmin = UserAdmin.new(name: "Gianfranco", surname: "Verdi", email: "mattew98.01@dis.uniroma1.it", username: "Giangi", password: "foobar2", password_confirmation: "foobar2")
    @userAdmin.save
    assert_not altroAdmin.valid?
  end
  
  test "email addresses should be unique (case-insensitive)" do
    altroAdmin = UserAdmin.new(name: "Gianfranco", surname: "Verdi", email: "mattew98.01@dis.uniroma1.it", username: "Giangi", password: "foobar2", password_confirmation: "foobar2")
    altroAdmin.email = @userAdmin.email.upcase
    @userAdmin.save
    assert_not altroAdmin.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@UnIRomA1.iT"
    @userAdmin.email = mixed_case_email
    @userAdmin.save
    assert_equal mixed_case_email.downcase, @userAdmin.reload.email
  end
  
  test "usernames should be unique" do
    altroAdmin = UserAdmin.new(name: "Gianfranco", surname: "Verdi", email: "giangi@uniroma1.it", username: "Mattew98-01", password: "foobar2", password_confirmation: "foobar2")
    @userAdmin.save
    assert_not altroAdmin.valid?
  end
  
  test "usernames should be unique (case-insensitive)" do
    altroAdmin = UserAdmin.new(name: "Gianfranco", surname: "Verdi", email: "giangi@uniroma1.it", username: "Mattew98-01", password: "foobar2", password_confirmation: "foobar2")
    altroAdmin.username = @userAdmin.username.upcase
    @userAdmin.save
    assert_not altroAdmin.valid?
  end
  
  test "usernames should be saved as lower-case" do
    mixed_case_username = "PrOVa"
    @userAdmin.username = mixed_case_username
    @userAdmin.save
    assert_equal mixed_case_username.downcase, @userAdmin.reload.username
  end
  
  test "password should have a minimum length of 6 characters" do
    @userAdmin.password = @userAdmin.password_confirmation = "a" * 5
    assert_not @userAdmin.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @userAdmin.authenticated?(:remember, '')
  end
end
