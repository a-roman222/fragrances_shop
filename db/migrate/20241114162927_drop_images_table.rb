class DropImagesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :images do |t|
      t.integer :fragrance_id, null: false
      t.string :name
      t.timestamps
    end
  end
end
