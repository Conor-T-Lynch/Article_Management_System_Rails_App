class Article < ApplicationRecord
    # Association with user
    belongs_to :user

    validates :title, presence: true, length: { maximum: 255 }
    validates :content, presence: true, length: { minimum: 10 }
end
