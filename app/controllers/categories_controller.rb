class CategoriesController < ApplicationController
	 before_action :fetch_category, only: %i[show edit update]

	 def new
 		 @category = Category.new
 		 authorize @category
   end

	 def create
			 @category = Category.new(category_params)
			 @category.save
			 authorize @category
   end

	 def show
   end

	 def index
  		@categories = policy_scope(Category)
   end

	 def edit
   end

  def update
 	end

	 private

	 def category_params
		  params.require(:category).permit(:name, :description)
	 end

	 def fetch_category
 		 @category = Category.find(params[:id])
 		 authorize @category
 	end
end
