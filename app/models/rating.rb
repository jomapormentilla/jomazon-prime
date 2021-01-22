class Rating < ApplicationRecord
    belongs_to :user
    belongs_to :product

    scope :personal_rating, -> (product, user){ where(product_id: product.id, user_id: user.id).first.value }
end
