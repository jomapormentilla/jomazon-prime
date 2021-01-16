module ProductsHelper
    def display_quantity
        if @product.quantity == 0 || @product.quantity == nil
            'Out of stock'
        else
            @product.quantity
        end
    end
end
