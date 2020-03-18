class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @communities = policy_scope(Community)
  end

  def show
    authorize @community

  end

  def create
  end

  def new
    @community = Community.new
    authorize @community
  end
end
