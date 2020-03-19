class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true
end
