class CreateCommunityCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :community_categories do |t|
      t.references :community, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
