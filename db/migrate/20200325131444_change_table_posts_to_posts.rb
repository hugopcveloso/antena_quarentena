class ChangeTablePostsToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_table :table_posts, :posts
  end
end
