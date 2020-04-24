class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true
      t.references :user, foreign_key: true
      t.boolean :upvote
      

      t.timestamps
    end
  end
end
