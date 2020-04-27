class Changedefault < ActiveRecord::Migration[5.2]
	def change
		change_column :comments, :upvotes, :integer, :default => 0
		change_column :comments, :downvotes, :integer, :default => 0
  end
end
