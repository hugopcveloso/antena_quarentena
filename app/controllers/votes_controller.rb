class VotesController < ApplicationController
	def create
		post_id = params[:post_id]
		vote = Vote.new
		authorize vote

		
		vote.user_id = current_user.id
		vote.upvote = params[:upvote]
		vote.post_id = params[:post_id]
		
	#check if vote by this user exists
		existing_vote = Vote.where(user: current_user, post_id: post_id)
		@new_vote = existing_vote.size < 1

		respond_to do |format| 
			format.js { 
				if existing_vote.size > 0
					existing_vote.first.destroy
				else
					if vote.save
						@success = true
					else
						@success = false
					end
				end

				@post = Post.find(post_id)
				@is_upvote = params[:upvote]
				authorize @post
				 
				render "votes/create"
			}
		end
	end

  private
  def vote_params 
    params.require(:vote).permit(:post_id, :upvote)
  end
end