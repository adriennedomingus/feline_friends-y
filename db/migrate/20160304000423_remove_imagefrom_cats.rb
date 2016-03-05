class RemoveImagefromCats < ActiveRecord::Migration
  def change
    remove_column :cats, :image
  end
end
