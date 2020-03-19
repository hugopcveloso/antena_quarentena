class Community < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  validates :name, presence: true
  validates :description, presence: true

end
