module CartsHelper
    def display_cart_products( cart )
        if !cart.empty?
            render partial: 'carts/display_cart_products'
        else
            content_tag :div, 'There are no items in your cart', class: 'alert alert-secondary text-center'
        end
    end
end