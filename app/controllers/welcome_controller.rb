class WelcomeController < ApplicationController
    before_action :current_user
    before_action :redirect_if_signup_incomplete

    def home
        @departments = Department.all.includes(products: [:seller])
        @sellers = User.all.where(account_type: 2).order(:company_name)
    end

    def search
        if !params[:q]
            redirect_to root_path
        end

        @products = Product.where("name LIKE ?", "%#{ params[:q] }%")
    end
end