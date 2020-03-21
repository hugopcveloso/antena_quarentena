class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commentable, polymorphic: true
      t.integer :upvotes
      t.integer :downvotes

      t.timestamps
    end
  end
end
