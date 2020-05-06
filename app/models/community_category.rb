class CommunityCategory < ApplicationRecord
  belongs_to :community
  belongs_to :category
end
