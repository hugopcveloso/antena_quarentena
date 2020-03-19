class Subscription < ApplicationRecord
  belongs_to :users
  belongs_to :community
end
