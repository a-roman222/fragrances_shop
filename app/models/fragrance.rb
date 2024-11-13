class Fragrance < ApplicationRecord
  belongs_to :genre
  belongs_to :group
  belongs_to :brand
end
