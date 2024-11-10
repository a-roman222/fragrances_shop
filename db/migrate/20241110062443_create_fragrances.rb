class CreateFragrances < ActiveRecord::Migration[7.2]
  def change
    create_table :fragrances do |t|
      t.string :name
      t.integer :price
      t.string :url_img
      t.text :description
      t.boolean :availability
      t.integer :stock
      t.references :genre, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
