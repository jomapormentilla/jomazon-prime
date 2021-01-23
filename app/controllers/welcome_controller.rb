class WelcomeController < ApplicationController
    before_action :current_user
    before_action :redirect_if_signup_incomplete

    def home
        @departments = Department.all.includes(products: [:seller, :ratings])
        @sellers = User.is_a_seller.order(:company_name)
    end

    def search
        if !params[:q]
            redirect_to root_path
        end

        @products = Product.where("name LIKE ?", "%#{ params[:q] }%").includes(:ratings, :seller, :department)
        @users = User.where("first_name LIKE ?", "%#{ params[:q] }%")
                    .or(User.where("last_name LIKE ?", "%#{ params[:q] }%"))
                    .or(User.where("company_name LIKE ?", "%#{ params[:q] }%"))
    end
end