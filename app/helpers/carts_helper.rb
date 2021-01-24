module CartsHelper
    def display_cart_products( cart )
        if !cart.empty?
            render partial: 'carts/display_cart_products'
        else
            content_tag :div, 'There are no items in your cart', class: 'alert alert-secondary text-center'
        end
    end

    def display_transaction( action )
        if current_user.account_type == 1
            content_tag :td, ("You purchased #{ link_to action.product.name, product_path( action.product ) } from #{ link_to action.seller.company_name, user_path( action.seller ) }").html_safe
        elsif current_user.account_type == 2
            content_tag :td, ("#{ link_to action.buyer.full_name, user_path( action.buyer ) } purchased #{ link_to action.product.name, product_path( action.product ) }").html_safe
        end
    end
end