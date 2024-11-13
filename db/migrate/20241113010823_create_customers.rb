class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :last_name
      t.string :user
      t.string :password
      t.string :email
      t.string :phone
      t.string :billing_address
      t.string :shipping_address

      t.timestamps
    end
  end
end
