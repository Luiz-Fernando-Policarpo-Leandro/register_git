require "test_helper"

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get usuarios_login_url
    assert_response :success
  end

  test "should get logout" do
    get usuarios_logout_url
    assert_response :success
  end
end
