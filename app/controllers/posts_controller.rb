class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :fetch_post, only: [:show]

  def index
    @posts = policy_scope(Posts)
  end

  def show
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
    @post = Post.find(params[:id])
    authorize @post
  end

  def fetch_community
    @community = Community.find(params[:community_id])
    authorize @community
  end


  def post_params
    params.require(:post).permit(:title, :body)
  end
end
