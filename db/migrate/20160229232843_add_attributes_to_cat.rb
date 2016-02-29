class AddAttributesToCat < ActiveRecord::Migration
  def change
    add_column :cats, :description, :string
    add_column :cats, :image, :string
    add_column :cats, :price, :integer
  end
end
