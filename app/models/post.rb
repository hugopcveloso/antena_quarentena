class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :comments, as: :commentable

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
