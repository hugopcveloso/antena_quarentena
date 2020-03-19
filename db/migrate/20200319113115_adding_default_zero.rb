class AddingDefaultZero < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :upvotes, :integer, default: 0
    add_column :posts, :downvotes, :integer, default: 0
    change_column_default :posts, :total_comments, :default => 0

  end
end
