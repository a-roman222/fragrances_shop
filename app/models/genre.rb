class Genre < ApplicationRecord
  has_many :fragrances
  
      # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  # Whitelist associations that can be searched by Ransack
  def self.ransackable_associations(auth_object = nil)
    ["fragrances"]
  end
end