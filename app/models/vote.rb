class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :user_id, scope: :post_id

  after_create :increment_vote
  after_destroy :decrement_vote

  private
  
  def increment_vote
    field = self.upvote ? :upvotes : :downvotes
    Post.find(self.post_id).increment(field).save
  end

  def decrement_vote
    field = self.upvote ? :upvotes : :downvotes
    Post.find(self.post_id).increment(field).save
  end
end
