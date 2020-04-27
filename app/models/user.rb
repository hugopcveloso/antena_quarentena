class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  acts_as_token_authenticatable
  has_many :comments
  has_many :votes
  has_many :communities, through: :subscriptions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def upvoted_post_ids
    self.votes.where(upvote: true, votable_type: "Post").pluck(:votable_id)
  end

  def downvoted_post_ids
    self.votes.where(upvote: false, votable_type: "Post").pluck(:votable_id)
	end

	def upvoted_comments_ids
    self.votes.where(upvote: true, votable_type: "Comment").pluck(:votable_id)
  end

	def downvoted_comments_ids
    self.votes.where(upvote: false, votable_type: "Comment").pluck(:votable_id)
	end
	

end
