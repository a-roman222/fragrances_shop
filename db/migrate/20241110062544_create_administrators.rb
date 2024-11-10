class CreateAdministrators < ActiveRecord::Migration[7.2]
  def change
    create_table :administrators do |t|
      t.string :user
      t.string :password
      t.string :full_name
      t.string :email

      t.timestamps
    end
  end
end
