class AddCategoryToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_reference :communities, :category, foreign_key: true
  end
end
