class CartsController < ApplicationController
    def show
        if params[:user_id]
            @user = User.find_by_id(params[:user_id])
            if !is_current_user?( @user )
                flash[:notice] = "Error: Invalid Cart."
                redirect_to root_path
            end
        else
            flash[:notice] = "Error: Invalid Cart. Access Denied."
            redirect_to root_path
        end
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
    end
end