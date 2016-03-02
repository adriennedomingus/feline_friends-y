class CreateCatOrders < ActiveRecord::Migration
  def change
    create_table :cat_orders do |t|
      t.references :cat, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
