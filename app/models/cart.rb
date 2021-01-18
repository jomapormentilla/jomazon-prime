class Cart < ApplicationRecord
    belongs_to :buyer, class_name: "User"
    
    has_many :cart_products
    has_many :products, through: :cart_products
end