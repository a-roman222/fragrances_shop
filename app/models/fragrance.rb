class Fragrance < ApplicationRecord
  belongs_to :brand
  belongs_to :genre
  belongs_to :group
  has_one_attached :image

    # Add the ransackable_associations method to allow searching through specific associations
    def self.ransackable_associations(auth_object = nil)
      # List the associations you want to make searchable
      ["brand", "genre", "group"]
    end
  
    # Optionally, define ransackable_attributes if needed (as previously suggested)
    def self.ransackable_attributes(auth_object = nil)
      ["availability", "description", "name", "price", "stock"]
    end
end
