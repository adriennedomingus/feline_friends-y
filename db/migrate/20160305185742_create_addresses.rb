class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :street
      t.string :zip
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
