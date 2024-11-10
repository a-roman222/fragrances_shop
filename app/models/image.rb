class Image < ApplicationRecord
    has_many :fragrances
    has_one_attached :file
end
