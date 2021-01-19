class Cart < ApplicationRecord
    belongs_to :buyer, class_name: "User"
    
    has_many :cart_products
    has_many :products, through: :cart_products

    def total_price
        total = 0
        self.products.each{ |p| total += p.price }
        
        total
    end
end