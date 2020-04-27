class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to :user
  after_create :nested_count
	has_many :votes, as: :votable
	validates :body, presence: true
	

  def find_post
    Post.find(self.commentable_id)
  end

	# comments calc_score
	def score
    if self.upvotes > 0 || self.downvotes > 0
      self.upvotes > 0 ? ( self.upvotes - self.downvotes ) : (self.downvotes * -1)
		else
      0
    end
  end

  def nested_count
    parent = commentable
    a = []
    while parent.is_a?(Comment)
      a << parent
      parent = parent.commentable
    end
    self.comments_count = a.size
    self.save
  end

  def increment_count
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

  def root_post
    parent = self.commentable
    a = []
    if self.commentable.is_a?(Post)
      return parent
    else
      while parent.is_a?(Comment)
        a << parent
        return self if parent.is_a?(Post)
        parent = parent.commentable
      end
      a.last.commentable
    end
  end

end
