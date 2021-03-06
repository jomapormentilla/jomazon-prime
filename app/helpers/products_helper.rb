module ProductsHelper
    def display_quantity
        if @product.quantity == 0 || @product.quantity == nil
            'Out of stock'
        else
            "#{ @product.quantity } in stock"
        end
    end

    def products_index_title
        if !@user.nil?
            "#{ @user.company_name }'s Products"
        elsif !@department.nil?
            "Products > #{ @department.name } (#{ @department.products.size })"
        else
            "All Products"
        end
    end

    def active_product_item( obj )
        if !@department.nil?
            "active" if obj.name == @department.name
        elsif !@user.nil?
            "active" if obj.first_name == @user.first_name
        end
    end

    def list_users_or_departments
        if !@department.nil?
            render partial: 'departments/list_departments', locals: { departments: @departments }
        elsif !@user.nil?
            render partial: 'users/list_sellers', locals: { sellers: @sellers }
        else
            render partial: 'departments/list_departments', locals: { departments: @departments }
        end
    end

    def product_action_button( product )
        if is_logged_in?
            link_to 'View Item', product_path(product), class: 'btn btn-warning text-white'
        else
            link_to 'Login to View Item', login_path, class: 'btn btn-info text-white'
        end
    end

    def product_image( product )
        if product.product_image.attached?
            link_to image_tag(url_for(product.product_image), class: 'card-img-top product-image-height'), product_path(product)
        else
            if product.image != nil
                    link_to image_tag(image_url(product.image), class: 'card-img-top product-image-height'), product_path(product)
            else
                link_to image_tag(image_url('placeholder-image.png'), class: 'card-img-top product-image-height'), product_path(product)
            end
        end
    end

    def product_edit_or_add_to_cart( product )
        if product.quantity == 0
            content_tag :div, "This item is out of stock", class: 'alert alert-danger text-center'
        else
            if product.seller.id == current_user.id
                link_to 'Edit Item', edit_product_path(product), class: 'btn btn-outline-warning'
            else
                if current_user.account_type == 1
                    if current_user.cart.cart_products.not_purchased.any?{|cart| cart.product == product }
                        content_tag :div, "This item is already in your cart", class: 'alert alert-warning text-center'
                    else
                        link_to 'Add Item to Cart', addtocart_path(product), class: 'btn btn-outline-warning'
                    end
                end
            end
        end
    end

    def display_cart
        if current_user.account_type == 1
            render partial: 'products/display_cart'
        else
            content_tag :div, "Hi, #{ current_user.first_name }! You'll need to create a Buyer account to purchase this item.", class: 'alert alert-dark text-center'
        end
    end

    def in_stock( product )
        if product.quantity > 0
            content_tag :span, "In Stock", class: 'in-stock'
        else
            content_tag :span, "Out of Stock", class: 'out-of-stock'
        end
    end

    def display_reviews
        if @reviews.empty?
            content_tag :div, "This product does not have any reviews.", class: 'alert alert-dark text-center'
        else
            render partial: 'products/display_reviews', locals: { reviews: @reviews }
        end
    end
end
