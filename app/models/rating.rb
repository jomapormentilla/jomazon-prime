class Rating < ApplicationRecord
    belongs_to :user
    belongs_to :product

    scope :personal_rating, -> (product){ where(product_id: product.id).first.value }
end
