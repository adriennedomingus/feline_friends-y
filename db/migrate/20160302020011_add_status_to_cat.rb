class AddStatusToCat < ActiveRecord::Migration
  def change
    add_column :cats, :status, :string, default: "active"
  end
end
