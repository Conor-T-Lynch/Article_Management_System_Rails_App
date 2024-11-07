require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Test for successful login with valid credentials
  test "should log in user with valid credentials" do
    user = users(:one)

    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal root_path, path
  end

  # Test for unsuccessful login with invalid credentials
  test "should not log in user with invalid credentials" do
    user = users(:one)  # Load the user fixture

    post user_session_path, params: {
      user: {
        email: "wrong@example.com",
        password: "incorrect_password"
      }
    }

    assert_response :unprocessable_entity
    assert_nil session["warden.user.user.key"]
  end

    # Test for successful logout
    test "should log out user" do
      user = users(:one)

      sign_in user

      delete destroy_user_session_path

      assert_response :redirect
      follow_redirect!
      assert_equal "/unauthenticated", path
      assert_nil session["warden.user.user.key"]
  end
end
