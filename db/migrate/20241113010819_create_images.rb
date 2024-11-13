class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.references :fragrance, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
