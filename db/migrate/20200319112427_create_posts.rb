class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :upvotes
      t.integer :downvotes
      t.references :community
      t.references :user
      t.timestamps
    end
  end
end
