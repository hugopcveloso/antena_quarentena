class CommunityCategoryController < ApplicationController
	def create
		authorize @community_category
  end

	def destroy
		authorize @community_category	
  end
end
