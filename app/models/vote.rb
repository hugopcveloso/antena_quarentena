class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

 
  after_create :increment_vote
  after_destroy :decrement_vote

  private
  
  def type
    
  end

  def increment_vote
    field = self.upvote ? :upvotes : :downvotes
    if self.votable_type == 'Post'
      Post.find(self.votable_id).increment(field).save
    else 
      Comment.find(self.votable_id).increment(field).save
    end
  end

  def decrement_vote
    field = self.upvote ? :upvotes : :downvotes
    if self.votable_type == 'Post'
      Post.find(self.votable_id).decrement(field).save
    else 
      Comment.find(self.votable_id).decrement(field).save
    end
  end
end
