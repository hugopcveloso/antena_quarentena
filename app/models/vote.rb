class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

 
  after_create :increment_vote
  after_destroy :decrement_vote

  private
  
  def type
    
  end

  def increment_vote
    if self.votable_type == 'Post'
      field = self.upvote ? :upvotes : :downvotes
      Post.find(self.votable_id).increment(field).save
    else 
      field = self.upvote ? :upvotes : :downvotes
      Comment.find(self.votable_id).increment(field).save
    end
  end

  def decrement_vote
    if self.votable_type == 'Post'
      field = self.upvote ? :upvotes : :downvotes
      Post.find(self.votable_id).decrement(field).save
    else 
      field = self.upvote ? :upvotes : :downvotes
      Comment.find(self.votable_id).decrement(field).save
    end
  end
end
