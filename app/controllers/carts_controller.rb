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

            flash[:notice] = "Item has been added to your cart."
            redirect_to product_path(@product)
        else
            flash[:notice] = "Error. Product not found."
            redirect_to product_path(@product)
        end
    end

    def checkout
    end
end