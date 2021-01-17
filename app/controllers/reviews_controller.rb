class ReviewsController < ApplicationController
    def create
        @review = Review.new(review_params)

        if @review.valid?
            @review.save
            redirect_to product_path(@review.product)
        else
            render :template => 'products/show'
        end 
    end

    private

    def review_params
        params.require(:review).permit(
            :content,
            :user_id,
            :product_id
        )
    end
end
