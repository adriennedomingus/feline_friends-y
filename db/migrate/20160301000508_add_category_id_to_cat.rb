class AddCategoryIdToCat < ActiveRecord::Migration
  def change
    add_reference :cats, :category, index: true, foreign_key: true
  end
end
