class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :product_id
      t.integer :price_at_purchase
      t.integer :quantity

      t.timestamps
    end
  end
end
