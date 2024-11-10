class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :order_status
  has_many :order_items
  has_many :fragrances, through: :order_items
end
