class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :ammount
      t.text :shipping_address
      t.string :shipping_email
      t.string :shipping_date
      t.references :order_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end