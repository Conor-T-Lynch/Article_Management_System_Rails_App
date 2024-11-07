require "test_helper"

class ArticleFlowTest < ActionDispatch::IntegrationTest
  setup do
    # Using the fixture user
    @user = users(:one)
    # Sign in the user
    sign_in @user
  end

  test "can create, view, edit, and destroy an article" do
    # Create an article
    post articles_path, params: { article: { title: "New Article", content: "This is a test article" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "New Article", response.body

    # Get the article's ID
    article = Article.last

    # View the article
    get article_path(article)
    assert_response :success
    assert_match "New Article", response.body

    # Edit the article
    patch article_path(article), params: { article: { title: "Updated Article" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Updated Article", response.body

    # Destroy the article
    delete article_path(article)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_no_match "Updated Article", response.body
  end
end
