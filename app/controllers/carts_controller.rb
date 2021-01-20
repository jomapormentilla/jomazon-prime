class CartsController < ApplicationController
    def show
        if params[:user_id]
            @user = User.find_by_id(params[:user_id])
            if !is_current_user?( @user )
                flash[:notice] = "Error: Invalid Cart."
                redirect_to root_path
            end
            @cart = current_user.cart.cart_products.not_purchased
        else
            flash[:notice] = "Error: Invalid Cart. Access Denied."
            redirect_to root_path
        end
    end

    def purchases
        @user = current_user
        @cart = current_user.cart.cart_products.purchased
    end

    def addtocart
        @product = Product.find_by_id(params[:id])
        
        if @product
            @cart = Cart.find_or_create_by(buyer_id: current_user.id)
            @cart.products << @product

            redirect_to product_path(@product)
        else
            flash[:notice] = "Error. Product not found."
            redirect_to product_path(@product)
        end
    end

    def remove_item
        @product = Product.find_by_id(params[:id])
        @cart = current_user.cart
        cart_products = @cart.cart_products.where(cart_id: @cart.id, product_id: @product.id).each{ |p| p.delete }

        flash[:notice] = "#{ @product.name } has been removed from your cart."
        redirect_to user_cart_path(current_user, current_user.cart)
    end

    def checkout
        new_balance = current_user.balance -= current_user.cart.total_price

        if new_balance < 0
            flash[:notice] = "Insufficient Funds"
            redirect_to user_cart_path( current_user, current_user.cart )
        else
            current_user.cart.cart_products.each do |cart_product|
                cart_product.purchased = true
                cart_product.save
            end
        end
        
        current_user.save

        redirect_to user_path( current_user )
    end
end