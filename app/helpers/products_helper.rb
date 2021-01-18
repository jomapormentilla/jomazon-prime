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
            "#{ @user.first_name }'s Products"
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
end
