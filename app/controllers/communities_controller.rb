class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
	before_action :fetch_community, only: [:show]
	before_action :fetch_category_images, only: [:new, :create]

  def index
    @communities = policy_scope(Community)
  end

  def show
    @posts = @community.posts.sort_by(&:score).reverse
    @subscriber_count = @community.subscribers.count
    @subscription = Subscription.new
  end

  def new
    @community = Community.new
		authorize @community
		
		
  end

  def create
    @community = Community.new(community_params)
    @community.user = current_user
    authorize @community
		if @community.save
			@categories = params["community"]["category_ids"].to_a.drop(1)
			gen_categories
      redirect_to community_path(@community)
    else
      render :new
    end
  end

  private

  def fetch_community
    @community = Community.find(params[:id])
    authorize @community
  end

  def community_params
    params.require(:community).permit(:name, :description)
	end

	def gen_categories
		@categories.each do |category_id|
			category = Category.find(category_id)
			CommunityCategory.create(category: category, community: @community)
		end
	end


	def fetch_category_images
		@images = [
			'https://images.unsplash.com/photo-1499529112087-3cb3b73cec95?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80',
			'https://images.unsplash.com/photo-1531834685032-c34bf0d84c77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=987&q=80',
			'https://images.unsplash.com/photo-1493804714600-6edb1cd93080?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1542626991-cbc4e32524cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1049&q=80',
			'https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1564939558297-fc396f18e5c7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80',
			'https://images.unsplash.com/photo-1485282451181-373ce0a1f879?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80',
			'https://images.unsplash.com/photo-1579684453423-f84349ef60b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1068&q=80',
			'https://images.unsplash.com/photo-1532204955314-0eb7a6fca713?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1550504630-cc20eca3b23e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1505664194779-8beaceb93744?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1488210740273-efea3f883282?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-1.2.1&auto=format&fit=crop&w=967&q=80',
			'https://images.unsplash.com/photo-1580983230712-f7d0f878bcc4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
			'https://images.unsplash.com/photo-1541969487406-1f1adf3884ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1055&q=80'
		]
	end
end
