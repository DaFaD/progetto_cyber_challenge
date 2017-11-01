require 'test_helper'

class UserStudenteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @userStudente = UserStudente.new(name: "daniele", surname: "Sinibaldi", email: "daniel46.95@gmail.com", username: "Daniel46-95", fiscalCode: "SNBDNL95H20C858U", birthDay: Date.new(1995, 6, 20))
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
    @userStudente.email = "a" * 244 + "@example.com"
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
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com utente@hotmail.it utente@live.com nome.cognome@alice.com]
    invalid_addresses.each do |invalid_address|
        @userStudente.email = invalid_address
        assert_not @userStudente.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
