class CommentsController < ApplicationController
  before_action :find_commentable, only: [:new, :create]


  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    authorize @comment
    post = Post.find(@comment.root_post.id)
    community = post.community
    anchor = "accordion#{@comment.id.to_words.delete(' ')}"
      redirect_to community_post_path(community, post, anchor: anchor)
  end
 #community_post GET    /communities/:community_id/posts/:id(.:format)

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :comment_id)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    elsif params[:post_id]
      @commentable = Post .find(params[:post_id])
    end
  end
end
