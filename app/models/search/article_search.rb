module Search::ArticleSearch
  def self.search(title)
    Article.where("title LIKE ?", "%#{title}%")
  end
end
