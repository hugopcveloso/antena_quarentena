class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index]

  def home
  end

  def index
    @communities = policy_scope(Community).limit(5)
    @posts = policy_scope(Post).order(id: :desc).limit(10)
  end

  def profile
    @profile = User.find_by_username(params[:username])
    @posts = @profile.posts
  end
  
end
