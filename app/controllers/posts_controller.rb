class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :fetch_post, only: %i[show edit update destroy upvote]
  before_action :auth_subscriber, only: [:new]

  def index
    @posts = policy_scope(Posts)
  end

  def show
    @comment = Comment.new
    authorize @comment
    respond_to do |format|
      format.html
      format.json do
        render json: { success: true, total_votes: @post.upvotes }
      end
    end
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

  def edit
  end

  def update
    redirect_to @post if @post.save(article_params)
  end

  def destroy
    redirect_to :back if @post.destroy
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

  def auth_subscriber
    fetch_community
    unless Subscription.where(community_id: @community.id, user_id: current_user.id).any?
      redirect_to root_path, flash: { danger: "Desculpa não estás autorizado a estar nesta página" }
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
