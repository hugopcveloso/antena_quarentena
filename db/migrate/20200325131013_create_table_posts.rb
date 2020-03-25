class CreateTablePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :table_posts do |t|
      t.string :title
      t.text :body
      t.integer :upvotes, default: 0
      t.integer :downvotes, default: 0
      t.integer :total_comments, default: 0
      t.references :community, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
