class Fragrance < ApplicationRecord
  belongs_to :genre
  belongs_to :brand
  belongs_to :group
end
