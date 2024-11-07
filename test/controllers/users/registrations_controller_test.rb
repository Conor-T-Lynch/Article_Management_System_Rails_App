require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Test successful user registration
  test "should register a new user with valid parameters" do
    assert_difference 'User.count', 1 do
      post user_registration_path, params: {
        user: {
          email: "testuser@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
    assert_redirected_to root_path  # Redirect after a successful sign-up (can vary based on config)
  end

  # Test registration with invalid parameters
  test "should not register a user with invalid parameters" do
    assert_no_difference 'User.count' do
      post user_registration_path, params: {
        user: {
          email: "invalid-email",
          password: "password123",
          password_confirmation: "mismatch"
        }
      }
    end
    assert_response :unprocessable_entity  # Or :unprocessable_entity if configured
  end

  # Test redirection for an already signed-in user
  test "should redirect signed-in user attempting to register again" do
    user = users(:one)  # Assuming a fixture user
    sign_in user

    get new_user_registration_path
    assert_redirected_to root_path  # Or wherever logged-in users are redirected
  end
end
