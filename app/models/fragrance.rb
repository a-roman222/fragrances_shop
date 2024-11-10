class Fragrance < ApplicationRecord
  belongs_to :genre
  belongs_to :brand
  belongs_to :group
  has_one_attached :image
  has_many :order_items
  has_many :orders, through: :order_items
end
