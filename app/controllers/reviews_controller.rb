class ReviewsController < ApplicationController
    def create
        @review = Review.new(review_params)
        @review.user_id = current_user.id

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
            :product_id
        )
    end
end
