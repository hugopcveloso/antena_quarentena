class VotesController < ApplicationController
	def create
		vote = Vote.new(vote_params)
		vote.user_id = current_user.id
		# vote.upvote = params[:upvote]
		# vote.votable_type = params[:votable_type]
		# vote.votable_id = params[:votable_id]
		authorize vote
		existing_vote = Vote.where(user: current_user, votable_type: vote.votable_type, votable_id: vote.votable_id)
		@new_vote = existing_vote.size < 1
		voted = vote.votable_type == 'Post' ? Post.find(vote.votable_id) : Comment.find(vote.votable_id)
		respond_to do |format| 
			format.json {
				if existing_vote.size > 0 
					last_vote = existing_vote[0].upvote
					existing_vote.first.destroy
					render json: { success: true, type: 'remove', newvote: false, all_votes: voted.upvotes, last_vote: last_vote}
				else
					if vote.save
						voted = vote.votable_type == 'Post' ? Post.find(vote.votable_id) : Comment.find(vote.votable_id)
						render json: { success: true, type: vote.upvote, newvote: @new_vote, all_votes: voted.upvotes }
					else
						render json: { success: false }, status: :unprocessable_entity
					end
				end
			}
		end
	end

	private 

	def vote_params
		params.require(:vote).permit(:votable_id, :upvote, :votable_type)
	end
end

