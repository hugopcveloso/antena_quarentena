class Community < ApplicationRecord
	 belongs_to :user
	 belongs_to :category
  has_many :posts
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
  validates :name, presence: true
  validates :description, presence: true

  def user_subscribed(user)
    Subscription.where(community_id: id, user_id: user.id).any? ? true : false
  end
end
