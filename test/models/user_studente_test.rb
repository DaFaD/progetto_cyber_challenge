require 'test_helper'

class UserStudenteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @userStudente = UserStudente.new(name: "daniele", surname: "Sinibaldi", email: "daniele.sinibaldi@hotmail.it", username: "Daniel46-95", fiscalCode: "SNBDNL95H20C858U", birthDay: Date.new(1995, 6, 20))
  end
  
  test "should be valid" do
    assert @userStudente.valid?
  end
  
  test "name should be present" do
    @userStudente.name = "    "
    assert_not @userStudente.valid?
  end
end
