class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @communities = policy_scope(Community)
  end

  def show
    authorize @community
  end



  def new
    @communit= Community.new
    authorize @community
  end


  def create
     @community = Comunity.new
  end


  private

  def community_params

  end
end
