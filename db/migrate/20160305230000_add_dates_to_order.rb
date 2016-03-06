class AddDatesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :start_date, :datetime
    add_column :orders, :end_date, :datetime
  end
end
