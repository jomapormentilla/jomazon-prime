class Cart < ApplicationRecord
    belongs_to :buyer, class_name: "User"
    
    has_many :cart_products
    has_many :products, through: :cart_products

    def total_price
        total = 0
        self.cart_products.each do |cart|
            total += cart.product.price if cart.purchased == false
        end
        
        total
    end
end