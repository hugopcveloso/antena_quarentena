module VotesHelper
	
	def is_upvoted(post)
		user_signed_in? && current_user.upvoted_post_ids.include?(post.id) ? "active" : "" 
	end

	def is_downvoted post
		user_signed_in? && current_user.downvoted_post_ids.include?(post.id) ? "active" : ""
	end

	def is_upvoted comment
		user_signed_in? && current_user.upvoted_comments_ids.include?(comment.id) ? "active" : "" 
	end

	def is_downvoted comment
		user_signed_in? && current_user.downvoted_comments_ids.include?(comment.id) ? "active" : ""
	end

end
 