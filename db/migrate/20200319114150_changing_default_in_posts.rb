class ChangingDefaultInPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :total_comments, 0
  end
end
