class Post < ApplicationRecord
    belongs_to :user
    belongs_to :crawl_datum
    has_many :comments
    has_many :commented_users, through: :comments, source: :user
end
