class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :fetch_community, only: [:show]

  def index
    raise
    @communities = policy_scope(Community).limit(5)

  end

  def show
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
end
