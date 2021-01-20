class ReviewsController < ApplicationController
    def create
        @review = Review.new(review_params)

        if @review.valid?
            @review.save
        else
            flash[:notice] = "Review cannot be blank."
        end 
        redirect_to product_path(@review.product)
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
