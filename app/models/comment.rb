class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to :user
  after_create :increment_count


  def find_post
    Post.find(self.commentable_id)
  end

  def increment_count
    parent = commentable
    a = []
    while parent.is_a?(Comment)
      a << parent
      parent = parent.commentable
    end
    self.comments_count = a.size
    self.save
  end

  def increment_counasdft
  parent = commentable
    while parent.is_a? Comment
      parent = parent.commentable
    end
    parent.increment! :comments_count
  end

  def root_index
    parent = commentable
    a = []
      while parent.is_a?(Comment)
        a << parent
        parent = parent.commentable unless parent.is_a?(Post)
      end
    a.last
  end

  def children

  end

end

