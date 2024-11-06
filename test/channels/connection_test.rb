require "test_helper"
# Define the test module for action cable connections
module ApplicationCable
  class ConnectionTest < ActionCable::Connection::TestCase
    # this block runs before each test
    setup do
      # loads the user fixture 'one'
      @user = users(:one)
      # Set the signed cookie with user_id to simulate user login
      cookies.signed[:user_id] = @user.id
      # calling the connect method to establish the connection
      connect
    end
    # test to ensure the connection is established with the correct user
    test "connects with cookies" do
      # assert that the current user in the connection matches the user from the fixture
      assert_equal connection.current_user.id, @user.id
    end
  end
end
