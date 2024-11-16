class ChangePriceToDecimalInFragrances < ActiveRecord::Migration[7.2]
  def change
    change_column :fragrances, :price, :decimal, precision: 10, scale: 2
  end
end
