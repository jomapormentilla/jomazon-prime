class RatingsController < ApplicationController
    def create
        @product = Product.find_by_id(params[:product_id])
        
        if @product
            redirect_if_rating_exists( @product )
            Rating.create(value: params[:rating].to_i, user_id: current_user.id, product_id: @product.id)
            flash[:notice] = "Thank you for your rating!"
            redirect_to product_path( @product )
        else
            flash[:notice] = "Error: Cannot find Product."
            redirect_to purchases_path
        end
    end

    private

    def redirect_if_rating_exists( product )
        @rating = Rating.find_by(product_id: product.id)
        if @rating
            flash[:notice] = "You have already rated this product."
            redirect_to purchases_path
        end
    end
end
