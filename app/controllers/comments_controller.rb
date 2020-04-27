class CommentsController < ApplicationController
  before_action :find_commentable, only: [:new, :create]


  def create
    @comment = @commentable.comments.new(comment_params)
		@comment.user = current_user
		authorize @comment
		post = Post.find(@comment.root_post.id)
		community = post.community
		
		authorize @comment
		if @comment.save
			anchor = "accordion#{@comment.id}"
			redirect_to community_post_path(community, post, anchor: anchor)
		else
			redirect_to community_post_path(community, post)
		end
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
