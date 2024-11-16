class Fragrance < ApplicationRecord

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :brand
  belongs_to :genre
  belongs_to :group
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["name","availability", "brand_id", "genre_id", "group_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["brand"]
  end

end
