class AddingTotalCommentsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :total_comments, :integer
  end
end
