class Genre < ApplicationRecord
    has_many :fragrances, dependent: :destroy
end
