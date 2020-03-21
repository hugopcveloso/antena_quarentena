class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable


  def find_post
    Post.find(self.commentable_id)
  end

end
