class Genre < ApplicationRecord
    has_many :fragrances
  
    # Define searchable attributes for Ransack
    def self.ransackable_attributes(auth_object = nil)
      ["name", "created_at", "updated_at"]
    end
  end