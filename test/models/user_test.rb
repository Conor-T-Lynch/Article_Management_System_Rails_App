require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    # Using the fixture
    @user = users(:one)
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should have a valid format" do
    @user.email = "invalid_email"
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should be valid" do
    assert @user.valid?
  end
end
