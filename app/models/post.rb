class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :comments, as: :commentable

  validates :title, presence: true
  validates :body, presence: true

  def total_votes
    return self.upvotes - self.downvotes
  end
end
