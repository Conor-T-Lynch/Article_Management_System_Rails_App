require "application_system_test_case"

class UserLoginTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "user can log in" do
    # Navigate to the login page
    visit new_user_session_path
    # Fill in the email
    fill_in "Email", with: @user.email
    # Fill in the password
    fill_in "Password", with: "password"
    # Click the login button
    click_on "Log in"

    # Assert that the user sees a successful login message
    assert_text "Signed in successfully."

    # Assert that the user is redirected to the root path
    assert_current_path root_path
  end
end
