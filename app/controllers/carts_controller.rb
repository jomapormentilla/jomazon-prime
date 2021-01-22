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
        @cart = current_user.cart.cart_products.purchased.order(id: :desc)
        @rating = Rating.find_by(user_id: current_user.id)
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
            flash[:notice] = "Error: Insufficient Funds."
            redirect_to user_cart_path( current_user, current_user.cart )
        else
            current_user.cart.cart_products.not_purchased.each do |cart_product|
                if cart_product.purchased == false
                    cart_product.product.seller.balance += cart_product.product.price
                    cart_product.product.seller.save
                    
                    cart_product.product.quantity -= 1
                    cart_product.product.save
                    
                    cart_product.purchased = true
                    cart_product.save
                end

                data = {
                    content: "#{ current_user.first_name } #{ current_user.last_name } purchased #{ cart_product.product.name }",
                    user_id: cart_product.product.seller.id,
                    price: cart_product.product.price
                }
                cart_product.product.seller.actions << Action.create(data)

                data = {
                    content: "You purchased #{ cart_product.product.name }",
                    user_id: current_user.id,
                    price: cart_product.product.price
                }
                current_user.actions << Action.create(data)
            end

            current_user.save
            redirect_to user_path( current_user )
        end
        
    end
end