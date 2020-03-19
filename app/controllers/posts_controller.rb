class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :fetch_post, only: [:show]
  before_action :auth_subscriber, only: [:new]

  def index
    @posts = policy_scope(Posts)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comment = Comment.new
  end

  def new
    fetch_community
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    fetch_community
    @post.community = @community
    authorize @post
    if @post.save
      redirect_to community_path(@post.community_id)
    else
      render :new
    end
  end

  private

  def fetch_post
    @post = Post.includes(:comments).find(params[:id])
    authorize @post
  end

  def fetch_community
    @community = Community.find(params[:community_id])
    authorize @community
  end

  def auth_subscriber
    fetch_community
    unless Subscription.where(community_id: @community.id, user_id: current_user.id).any?
      redirect_to root_path, flash: { danger: "Desculpa não estás autorizado a estar nesta página"}
    else

    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
