class AddStatusTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cancelled_at, :datetime
    add_column :orders, :returned_at, :datetime
  end
end
