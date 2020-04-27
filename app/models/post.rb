class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  validates :title, presence: true
  validates :body, presence: true

  def score
    if self.upvotes > 0 || self.downvotes > 0
      self.upvotes > 0 ? ( self.upvotes - self.downvotes ) : (self.downvotes * -1)
    else
      0
    end
  end
end
