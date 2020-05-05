class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
			t.text :description
			t.integer :total_communities, default: 0
			t.integer :total_posts, default: 0

      t.timestamps
    end
  end
end
