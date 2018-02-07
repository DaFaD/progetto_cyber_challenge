require 'test_helper'

class UserStudenteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @userStudente = UserStudente.new(name: "Matteo", surname: "Vari", email: "mattew98.01@gmail.com", username: "Mattew98-01", fiscalCode: "VRAMTT98M06C858Y", birthDay: Date.new(1998, 8, 6), password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @userStudente.valid?
  end
  
  test "name should be present" do
    @userStudente.name = "    "
    assert_not @userStudente.valid?
  end
  
  test "surname should be present" do
    @userStudente.surname = ""
    assert_not @userStudente.valid?
  end
  
  test "email should be present" do
    @userStudente.email = " "
    assert_not @userStudente.valid?
  end
  
  test "username should be present" do
    @userStudente.username = " "
    assert_not @userStudente.valid?
  end
  
  test "fiscal code should be present" do
    @userStudente.fiscalCode = " "
    assert_not @userStudente.valid?
  end
  
  test "birth day should be present" do
    @userStudente.birthDay = nil
    assert_not @userStudente.valid?
  end
  
  test "name should not be too long" do
    @userStudente.name = "a" * 51
    assert_not @userStudente.valid?
  end
  
  test "surname should not be too long" do
    @userStudente.surname = "a" * 51
    assert_not @userStudente.valid?
  end
  
  test "email should not be too long" do
    @userStudente.email = "a" * 246 + "@gmail.com"
    assert_not @userStudente.valid?
  end
  
  test "username should not be too long" do
    @userStudente.username = "a" * 51
    assert_not @userStudente.valid?
  end
  
  test "fiscal code should not be longer than 16 char" do
    @userStudente.fiscalCode = "a" * 17
    assert_not @userStudente.valid?
  end
  
  test "fiscal code should not be shorter than 16 char" do
    @userStudente.fiscalCode = "a" * 15
    assert_not @userStudente.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[nome.85-92@gmail.com utente@gmail.it utente@gmail.com cognome.1749374@studenti.uniroma1.it]
    valid_addresses.each do |valid_address|
        @userStudente.email = valid_address
        assert @userStudente.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com utente@hotmail.it utente@live.com nome.cognome@alice.com utente@gmail..com.]
    invalid_addresses.each do |invalid_address|
        @userStudente.email = invalid_address
        assert_not @userStudente.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "fiscal code validation should accept valid codes" do
    valid_codes = %w[RSSMRC80A01H501W DVLFNC93M52F205E rssmrc80a01h501w dvlfnc93m52f205e RMCNTN01S07C858L rmcntn01s07c858l]
    valid_codes.each do |valid_code|
        @userStudente.fiscalCode = valid_code
        assert @userStudente.valid?, "#{valid_code.inspect} should be valid"
    end
  end
  
  test "fiscal code validation should reject invalid codes" do
    invalid_codes = %w[RSSMRC80901H501W DVLFNC9EM52F205E rssmrc80z01z501w dvlfnc93752f205e RMCNTN01S07W858L rmcntn01s0jc858l RS8MRC80A01H501W]
    invalid_codes.each do |invalid_code|
        @userStudente.fiscalCode = invalid_code
        assert_not @userStudente.valid?, "#{invalid_code.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    altroStudente = UserStudente.new(name: "Gianfranco", surname: "Verdi", email: "mattew98.01@gmail.com", username: "Giangi", fiscalCode: "GNFVRD00H04H501Q", birthDay: Date.new(2000, 6, 4), password: "foobar2", password_confirmation: "foobar2")
    @userStudente.save
    assert_not altroStudente.valid?
  end
  
  test "email addresses should be unique (case-insensitive)" do
    altroStudente = UserStudente.new(name: "Gianfranco", surname: "Verdi", email: "mattew98.01@gmail.com", username: "Giangi", fiscalCode: "GNFVRD00H04H501Q", birthDay: Date.new(2000, 6, 4), password: "foobar2", password_confirmation: "foobar2")
    altroStudente.email = @userStudente.email.upcase
    @userStudente.save
    assert_not altroStudente.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@GmaIL.CoM"
    @userStudente.email = mixed_case_email
    @userStudente.save
    assert_equal mixed_case_email.downcase, @userStudente.reload.email
  end
  
  test "usernames should be unique" do
    altroStudente = UserStudente.new(name: "Gianfranco", surname: "Verdi", email: "giangi@gmail.com", username: "Mattew98-01", fiscalCode: "GNFVRD00H04H501Q", birthDay: Date.new(2000, 6, 4), password: "foobar2", password_confirmation: "foobar2")
    @userStudente.save
    assert_not altroStudente.valid?
  end
  
  test "usernames should be unique (case-insensitive)" do
    altroStudente = UserStudente.new(name: "Gianfranco", surname: "Verdi", email: "giangi@gmail.com", username: "Mattew98-01", fiscalCode: "GNFVRD00H04H501Q", birthDay: Date.new(2000, 6, 4), password: "foobar2", password_confirmation: "foobar2")
    altroStudente.username = @userStudente.username.upcase
    @userStudente.save
    assert_not altroStudente.valid?
  end
  
  test "usernames should be saved as lower-case" do
    mixed_case_username = "PrOVa"
    @userStudente.username = mixed_case_username
    @userStudente.save
    assert_equal mixed_case_username.downcase, @userStudente.reload.username
  end
  
  test "fiscal codes should be unique" do
    altroStudente = UserStudente.new(name: "Gianfranco", surname: "Verdi", email: "giangi@gmail.com", username: "Giangi", fiscalCode: "VRAMTT98M06C858Y", birthDay: Date.new(2000, 6, 4), password: "foobar2", password_confirmation: "foobar2")
    @userStudente.save
    assert_not altroStudente.valid?
  end
  
  test "fiscal codes should be unique (case-insensitive)" do
    altroStudente = UserStudente.new(name: "Gianfranco", surname: "Verdi", email: "giangi@gmail.com", username: "Giangi", fiscalCode: "vramtt98m06c858y", birthDay: Date.new(2000, 6, 4), password: "foobar2", password_confirmation: "foobar2")
    altroStudente.fiscalCode = @userStudente.fiscalCode.upcase
    @userStudente.save
    assert_not altroStudente.valid?
  end
  
  test "fiscal codes should be saved as lower-case" do
    mixed_case_fiscalCode = "RsSmRC80A01H501w"
    @userStudente.fiscalCode = mixed_case_fiscalCode
    @userStudente.save
    assert_equal mixed_case_fiscalCode.downcase, @userStudente.reload.fiscalCode
  end
  
  test "password should have a minimum length of 6 characters" do
    @userStudente.password = @userStudente.password_confirmation = "a" * 5
    assert_not @userStudente.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @userStudente.authenticated?(:remember, '')
  end
end
