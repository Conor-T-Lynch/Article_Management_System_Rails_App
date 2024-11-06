require "test_helper"

# Defines a test class for the article model, which is also inheriting from the ActiveSupport::TestCase
class ArticleTest < ActiveSupport::TestCase
  # Set's up a valid instance of article for testing before every test
  def setup
    # Load a user fixture to associate with the article
    @user = users(:one)  # Ensure you have this user fixture defined
    # Creates a new article object which contains a sample title, content, and associated user
    @article = Article.new(title: "Sample Title", content: "Sample content for the article.", user: @user)
  end

  # Test that checks if the article is valid with the provided attributes
  test "should be valid" do
    # Asserting that the article is valid
    assert @article.valid?
  end

  # Test ensuring that the title of the object is present
  test "title should be present" do
    # Setting the title to an empty string
    @article.title = ""
    # Asserting that the article is not valid
    assert_not @article.valid?
  end

  # Test ensuring that the content of the object is present
  test "content should be present" do
    # Setting the content to an empty string
    @article.content = ""
    # Asserting that the article is not valid
    assert_not @article.valid?
  end

  # Test checking that the maximum length of the title is not exceeded
  test "title should have a maximum length" do
    # Setting the title to a string exceeding the maximum limit
    @article.title = "a" * 256
    # Asserting that the article is not valid
    assert_not @article.valid?
  end

  # Test checking that the minimum length of the article content
  test "content should have a minimum length" do
    # Setting the content to a string less than minimum length
    @article.content = "a" * 9
    # Asserting that the article is not valid
    assert_not @article.valid?
  end

  # Test ensuring that the user is present
  test "user should be present" do
    # Setting the user to nil
    @article.user = nil
    # Asserting that the article is not valid
    assert_not @article.valid?
  end
end
