class CartProduct < ApplicationRecord
    belongs_to :cart
    belongs_to :product

    scope :not_purchased, -> { where(purchased: false ) }
    scope :purchased, -> { where(purchased: true ) }
end