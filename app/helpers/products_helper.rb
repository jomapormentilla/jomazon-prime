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
            "#{ @department.name } Products"
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
        end
    end
end
