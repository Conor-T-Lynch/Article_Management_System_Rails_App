require "test_helper"

class ArticleSearchTest < ActionDispatch::IntegrationTest
  setup do
    # Create a test user using fixtures
    @user = users(:one)

    # Create sample articles for the search tests, ensuring they are associated with the user
    @article1 = Article.create(title: "Rails Testing Guide", content: "Learn how to test Rails applications.", user: @user)
    @article2 = Article.create(title: "Introduction to Ruby", content: "Get started with Ruby programming language.", user: @user)

    # Sign in the user using Devise's helper
    sign_in @user
  end

  test "search returns relevant articles" do
    # Perform a search for the term "Ruby"
    get articles_path, params: { query: "Ruby" }

    # Check that the response is successful
    assert_response :success

    # Check if the articles heading is present
    assert_select "h1", text: "Articles"

    # Verify that the article with "Ruby" in the title appears in the response
    assert_select "td", text: @article2.title
  end

  test "search with no matches" do
    # Perform a search for a term that has no matches
    get articles_path, params: { query: "Nonexistent Term" }

    # Check that the response is successful
    assert_response :success

    # Verify that no articles are displayed and that "Articles" is still the heading
    assert_select "h1", text: "Articles"
    assert_select "td", count: 0
  end
end
