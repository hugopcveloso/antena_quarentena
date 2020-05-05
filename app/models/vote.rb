class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  after_create :increment_vote
  after_destroy :decrement_vote

  private

  def increment_vote
    field = upvote ? :upvotes : :downvotes
		  if votable_type == 'Post'
  			 post = Post.find(votable_id).increment(field).save
    else
  			 comment = Comment.find(votable_id).increment(field).save
      end
  end

  def decrement_vote
    field = upvote ? :upvotes : :downvotes
		if votable_type == 'Post'
			if Post.where(id: votable_id).any?
				post = Post.find(votable_id).decrement(field).save
			end
		else
			if Comment.where(id: votable_id).any?	
			  comment = Comment.find(votable_id).decrement(field).save
			end
		end
	end
end
