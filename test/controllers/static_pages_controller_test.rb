require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get paginaIniziale" do
    get :paginaIniziale
    assert_response :success
  end

end
