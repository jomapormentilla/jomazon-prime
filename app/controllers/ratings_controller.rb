class RatingsController < ApplicationController
    def create
        @product = Product.find_by_id(params[:product_id])

        if @product
            Rating.create(value: params[:rating].to_i, user_id: current_user.id, product_id: @product.id)
            flash[:notice] = "Thank you for your rating!"
            redirect_to product_path( @product )
        else
            flash[:notice] = "Error: Cannot find Product."
            redirect_to purchases_path
        end
    end
end
