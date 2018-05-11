class User < ApplicationRecord
  has_many :user_selects
  has_many :user_geocodes
  has_many :user_translates
  has_many :posts
  has_many :commented_posts, through: :comments, source: :post

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
